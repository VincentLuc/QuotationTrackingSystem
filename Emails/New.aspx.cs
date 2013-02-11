using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class Emails_New : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDdl();
        }
    }

    private void BindCategories(object sender, EventArgs e)
    {
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _currentUserName = User.Identity.Name;
        var _sentTo = int.Parse(ddlSentTo.SelectedValue);
        var _currentUserId = CurrentUser.Id();
        Email email = new Email { Subject = txtSubject.Text.Trim(), Body = txtBody.Text.Trim(), IsRead = "False", FromUserId = _currentUserId, FromUserName = _currentUserName, UserId = _sentTo, CreatedAt = DateTime.Now };
        _quotationTrackingSystemDBEntities.AddToEmails(email);
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully sent an email !";
        Response.Redirect("Inbox.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Inbox.aspx");
    }

    protected void BindDdl()
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _currentUserId = CurrentUser.Id();
        DataTable table = new DataTable();
        table.Columns.Add("Text");
        table.Columns.Add("Value");
        DataRow defaultRow = table.NewRow();
        defaultRow["Text"] = "Select";
        defaultRow["Value"] = 0;
        table.Rows.Add(defaultRow);
        foreach (var x in _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id != _currentUserId).OrderBy(x => x.CreatedAt).ToList())
        {
            DataRow dr = table.NewRow();
            dr["Value"] = x.Id;
            dr["Text"] = x.UserName;
            table.Rows.Add(dr);
        }

        ddlSentTo.DataSource = table;
        ddlSentTo.DataTextField = table.Columns["Text"].ColumnName;
        ddlSentTo.DataValueField = table.Columns["Value"].ColumnName;
        ddlSentTo.DataBind();
        ddlSentTo.SelectedIndexChanged += new System.EventHandler(BindCategories);
    }
}