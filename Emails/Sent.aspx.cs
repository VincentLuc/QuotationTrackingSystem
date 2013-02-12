using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class Emails_Sent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindDataToGridView();
    }
    protected void gvSentEmails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSentEmails.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }
    protected void gvSentEmails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;
    }

    public void BindDataToGridView()
    {
        QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _currentUserId = CurrentUser.Id();
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("Sent At", typeof(string)));
        dt.Columns.Add(new DataColumn("Sent To", typeof(string)));
        dt.Columns.Add(new DataColumn("Subject", typeof(string)));

        foreach (var x in _quotationTrackingSystemDBEntities.Emails.Where(x => x.FromUserId == _currentUserId).OrderByDescending(x => x.CreatedAt).ToList())
        {
            dr = dt.NewRow();
            dr["Sent At"] = DateTimeHelper.To24Hours(x.CreatedAt);
            dr["Sent To"] = x.tblUser.UserName;
            dr["Subject"] = x.Subject;
            dt.Rows.Add(dr);
        }

        gvSentEmails.DataSource = dt;
        gvSentEmails.DataBind();
    }
}