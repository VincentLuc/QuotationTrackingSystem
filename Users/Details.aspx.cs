using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class Users_Details : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected tblUser _user;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            hdnFldUserId.Value = Request.QueryString["id"];
        }
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var UserId = int.Parse(hdnFldUserId.Value);
        _user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == UserId).First();
        if (_user.Role == "SalesSupervisor"){
            BindDataToGridView();
        }
    }

    protected void gvSalesUser_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;

        var SalesSupervisorId = e.Row.Cells[8].Text.Split('#')[0];
        var SalesUserId = e.Row.Cells[8].Text.Split('#')[1];
        var EditUrl = "~/Users/EditSalesUser.aspx?SupervisorId=" + SalesSupervisorId + "&SalesUserId=" + SalesUserId;
        LinkButton lb = new LinkButton();
        lb.CommandArgument = e.Row.Cells[8].Text;
        lb.CommandName = "NumClick";
        lb.Text = "Edit";
        lb.PostBackUrl = EditUrl;
        e.Row.Cells[8].Controls.Add((Control)lb);

        LinkButton lb1 = new LinkButton();
        lb1.CommandArgument = e.Row.Cells[9].Text;
        lb1.CommandName = "NumClick";
        lb1.Text = "Change Password";
        lb1.PostBackUrl = "~/Users/ChangePassword.aspx?id=" + e.Row.Cells[9].Text;
        e.Row.Cells[9].Controls.Add((Control)lb1);

        for (int i = 0; i < e.Row.Cells.Count; i++)
        {
            e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Center;
        }
    }

    protected void gvSalesUser_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSalesUser.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }

    protected void BindDataToGridView() {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("First Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Middle Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Last Name", typeof(string)));
        dt.Columns.Add(new DataColumn("User Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Role", typeof(string)));
        dt.Columns.Add(new DataColumn("Status", typeof(string)));
        dt.Columns.Add(new DataColumn("Created At", typeof(string)));
        dt.Columns.Add(new DataColumn("Sign in Count", typeof(string)));
        dt.Columns.Add(new DataColumn("Edit", typeof(string)));
        dt.Columns.Add(new DataColumn("Change Password", typeof(string)));

        int SupervisorId = int.Parse(hdnFldUserId.Value);
        foreach (var x in _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Role == "Sales").Where(x => x.SupervisorId == SupervisorId).ToList())
        {
            dr = dt.NewRow();
            dr["First Name"] = x.FirstName;
            dr["Middle Name"] = x.MiddleName;
            dr["Last Name"] = x.LastName;
            dr["User Name"] = x.UserName;
            dr["Role"] = StringHelper.ToSentenceCase(x.Role);
            dr["Status"] = x.Status;
            dr["Created At"] = DateTimeHelper.ConvertToString(x.CreatedAt.ToString());
            dr["Sign in Count"] = x.SignInCount;
            dr["Edit"] = x.SupervisorId + "#" + x.Id;
            dr["Change Password"] = x.Id;
            dt.Rows.Add(dr);
        }

        gvSalesUser.DataSource = dt;
        gvSalesUser.DataBind();
    }
}