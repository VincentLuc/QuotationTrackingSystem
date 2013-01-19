using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class SalesSupervisor_Details : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    public List<VisitDetails> _visitDetailsList;
    public VisitDetails _visitDetails;
    protected void Page_Load(object sender, EventArgs e)
    {
        var salesUserId = int.Parse(Request.QueryString["id"]);
        int CurrentUserId = CurrentUser.Id();
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var count = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == salesUserId && x.SupervisorId == CurrentUserId).Count();
        if (count == 0) { 
            Session["ErrorMessage"] = "You are not authorized to access that sales user details !";
            Response.Redirect(CurrentUser.GetRedirectPath(CurrentUser.Role()));
            return;
        }
        if (!IsPostBack) {
            hdnFldSalesUserId.Value = salesUserId.ToString();
            txtQueryDate.Text = DateTime.Now.ToString("dd-MM-yyyy");
            BindDataToGridView();
        }
    }

    protected void gvVisitDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvVisitDetails.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataToGridView();
    }

    public void BindDataToGridView() {
        List<VisitDetails> _visitDetailsListx = GetList();

        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("User Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Line of Insurance", typeof(string)));
        dt.Columns.Add(new DataColumn("Status", typeof(string)));
        dt.Columns.Add(new DataColumn("Total", typeof(string)));

        foreach (var x in _visitDetailsListx)
        {
            dr = dt.NewRow();
            dr["User Name"] = x.UserName;
            dr["Line of Insurance"] = x.LineOfInsurance;
            dr["Status"] = StringHelper.ToSentenceCase(x.Status.ToString());
            dr["Total"] = x.Count;
            dt.Rows.Add(dr);
        }

        gvVisitDetails.DataSource = dt;
        gvVisitDetails.DataBind();
    }

    public List<VisitDetails> GetList() {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        DateTime startTime;
        DateTime endTime;
        DateTimeHelper.GetStartAndEndTime(txtQueryDate.Text, out startTime, out endTime);
        int salesUserId = int.Parse(hdnFldSalesUserId.Value);
        var qurey =
           from v in _quotationTrackingSystemDBEntities.Visits
           join u in _quotationTrackingSystemDBEntities.tblUsers
           on v.UserId equals u.Id
           where v.CreatedAt >= startTime && v.CreatedAt <= endTime && u.Id == salesUserId
           group v by new {u.UserName, v.LineOfInsurance, v.Status } into x
           select new { x.Key.UserName, x.Key.LineOfInsurance, x.Key.Status, countx = x.Count() };

        var dataList = qurey.ToList();
        _visitDetailsList = new List<VisitDetails>();
        foreach (var x in dataList)
        {
            _visitDetails = new VisitDetails();
            _visitDetails.UserName = x.UserName;
            _visitDetails.Count = x.countx;
            _visitDetails.LineOfInsurance = x.LineOfInsurance;
            _visitDetails.Status = x.Status;
            _visitDetailsList.Add(_visitDetails);
        }
        return _visitDetailsList;
    }
}
