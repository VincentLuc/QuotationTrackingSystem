using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class SalesSupervisor_TodaysVisit : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected List<VisitDetails> _visitDetailsList;
    protected VisitDetails _visitDetails;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtQueryDate.Text = DateTime.Now.ToString("dd-MM-yyyy");
            BindDataToGridView();
        }
    }

    protected void gvTodaysSalesVisits_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvTodaysSalesVisits.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataToGridView();
    }

    protected void BindDataToGridView()
    {
        List<VisitDetails> visitDetails = GetVisitList();
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("User Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Visited At", typeof(string)));
        dt.Columns.Add(new DataColumn("Total Visits", typeof(string)));
        
        int CurrentUserId = CurrentUser.Id();
        var list = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.SupervisorId == CurrentUserId).ToList();

        foreach (var x in visitDetails)
        {
            dr = dt.NewRow();
            dr["User Name"] = x.UserName;
            dr["Visited At"] = x.VisitedAt;
            dr["Total Visits"] = x.Count;
            dt.Rows.Add(dr);
        }

        gvTodaysSalesVisits.DataSource = dt;
        gvTodaysSalesVisits.DataBind();
    }

    protected List<VisitDetails> GetVisitList() {
        DateTime startTime;
        DateTime endTime;
        DateTimeHelper.GetStartAndEndTime(txtQueryDate.Text, out startTime, out endTime);
        int currentUserId = CurrentUser.Id();
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var qurey =
          from v in _quotationTrackingSystemDBEntities.Visits
          join u in _quotationTrackingSystemDBEntities.tblUsers
            on v.UserId equals u.Id
          where v.CreatedAt >= startTime && v.CreatedAt <= endTime && u.SupervisorId == currentUserId
          group v by new { y = v.CreatedAt.Year, m = v.CreatedAt.Month, d = v.CreatedAt.Day, u.UserName } into x
          select new { x.Key.UserName, x.Key.d, x.Key.m, x.Key.y, countx = x.Count() };

        var dataList = qurey.ToList();

        _visitDetailsList = new List<VisitDetails>();
        foreach (var x in dataList)
        {
            _visitDetails = new VisitDetails();
            _visitDetails.UserName = x.UserName;
            _visitDetails.VisitedAt = x.d.ToString() + "-" + x.m.ToString() + "-" + x.y.ToString();
            _visitDetails.Count = x.countx;
            _visitDetailsList.Add(_visitDetails);
        }
        return _visitDetailsList;
    }

}