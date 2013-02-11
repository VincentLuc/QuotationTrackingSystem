using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class Emails_Inbox : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindDataToGridView();
    }

    protected void gvInbox_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvInbox.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }

    protected void gvInbox_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;
        var array = e.Row.Cells[3].Text.Split('#');
        e.Row.CssClass = array[1] == "True" ? "read" : "unread";
        LinkButton lb;
        lb = new LinkButton();
        lb.CommandArgument = array[0];
        lb.CommandName = "NumClick";
        lb.Text = "Details";
        lb.PostBackUrl = "Details.aspx?id=" + array[0];
        e.Row.Cells[3].Controls.Add((Control)lb);
    }

    protected void BindDataToGridView()
    {
        QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _currentUserId = CurrentUser.Id();
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("Recieved At", typeof(string)));
        dt.Columns.Add(new DataColumn("From", typeof(string)));
        dt.Columns.Add(new DataColumn("Subject", typeof(string)));
        dt.Columns.Add(new DataColumn("Details", typeof(string)));

        foreach (var x in _quotationTrackingSystemDBEntities.Emails.Where(x => x.UserId == _currentUserId).OrderByDescending(x => x.CreatedAt).ToList())
        {
            dr = dt.NewRow();
            dr["Recieved At"] = DateTimeHelper.To24Hours(x.CreatedAt);
            dr["From"] = x.FromUserName;
            dr["Subject"] = x.Subject;
            dr["Details"] = x.Id.ToString() + "#" + x.IsRead;
            dt.Rows.Add(dr);
        }

        gvInbox.DataSource = dt;
        gvInbox.DataBind();
    }
}