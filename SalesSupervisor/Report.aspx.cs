using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;
using System.Data.Objects.SqlClient;

public partial class SalesSupervisor_Report : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.ToString("dd-MM-yyyy");
            txtToDate.Text = DateTime.Now.ToString("dd-MM-yyyy");
            BindDataToGridView();
        }
    }

    protected void gvVisitingReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvVisitingReport.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataToGridView();
    }

    protected void BindDataToGridView() {
        List<VisitDetails> visitDetails = GetVisitList();
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("User Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Line of Insurance", typeof(string)));
        dt.Columns.Add(new DataColumn("Status", typeof(string)));
        dt.Columns.Add(new DataColumn("Visited At", typeof(string)));
        dt.Columns.Add(new DataColumn("Total Visits", typeof(string)));

        foreach (var x in visitDetails)
        {
            dr = dt.NewRow();
            dr["User Name"] = x.UserName;
            dr["Line of Insurance"] = StringHelper.ToSentenceCase(x.LineOfInsurance);
            dr["Status"] = StringHelper.ToSentenceCase(x.Status);
            dr["Visited At"] = x.VisitedAt;
            dr["Total Visits"] = x.Count;
            dt.Rows.Add(dr);
        }

        gvVisitingReport.DataSource = dt;
        gvVisitingReport.DataBind();
    }

    protected List<VisitDetails> GetVisitList() {
        int currentUserId = CurrentUser.Id();
        var fromDate = txtFromDate.Text.Split('-');
        var toDate = txtToDate.Text.Split('-');
        var startTime = DateTime.Parse(fromDate[2] + "-" + fromDate[1] + "-" + fromDate[0] + " 00:00:00");
        var endTime = DateTime.Parse(toDate[2] + "-" + toDate[1] + "-" + toDate[0] + " 23:59:59");

        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();

        var query = from v in _quotationTrackingSystemDBEntities.Visits
                    join u in _quotationTrackingSystemDBEntities.tblUsers
                    on v.UserId equals u.Id
                    where v.CreatedAt >= startTime && v.CreatedAt <= endTime && u.SupervisorId == currentUserId
                    group v by new { y = v.CreatedAt.Year, m = v.CreatedAt.Month, d = v.CreatedAt.Day, u.UserName, v.LineOfInsurance, v.Status } into x
                    let VisitedAt = SqlFunctions.StringConvert((decimal) x.Key.d) + "-" + SqlFunctions.StringConvert((decimal) x.Key.m) + "-" + SqlFunctions.StringConvert((decimal) x.Key.y)
                    orderby VisitedAt
                    select new { x.Key.UserName, x.Key.d, x.Key.m, x.Key.y, x.Key.LineOfInsurance, x.Key.Status, countx = x.Count() };
        var listData = query.ToList();

        var list = new List<VisitDetails>();
        VisitDetails visitDetail;

        foreach (var x in listData) {
            visitDetail = new VisitDetails();
            visitDetail.UserName = x.UserName;
            visitDetail.LineOfInsurance = x.LineOfInsurance;
            visitDetail.Status = x.Status;
            visitDetail.VisitedAt = x.d.ToString() + "-" + x.m.ToString() + "-" + x.y.ToString();
            visitDetail.Count = x.countx;
            list.Add(visitDetail);
        }

        return list;

    }

}