using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class Users_Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindDataToGridView();
    }

    protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;

        LinkButton lb = new LinkButton();
        lb.CommandArgument = e.Row.Cells[9].Text;
        lb.CommandName = "NumClick";
        lb.Text = "Edit";
        lb.PostBackUrl = "~/Users/Edit.aspx?id=" + e.Row.Cells[9].Text;
        e.Row.Cells[9].Controls.Add((Control)lb);

        LinkButton lb1 = new LinkButton();
        lb1.CommandArgument = e.Row.Cells[10].Text;
        lb1.CommandName = "NumClick";
        lb1.Text = "Change Password";
        lb1.PostBackUrl = "~/Users/ChangePassword.aspx?id=" + e.Row.Cells[10].Text;
        e.Row.Cells[10].Controls.Add((Control)lb1);

        for (int i = 0; i < e.Row.Cells.Count; i++)
        {
            e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Center;
        }
    }

    protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvUsers.PageIndex = e.NewPageIndex;
        BindDataToGridView();

    }

    protected void BindDataToGridView() {
        QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("First Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Middle Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Last Name", typeof(string)));
        dt.Columns.Add(new DataColumn("User Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Role", typeof(string)));
        dt.Columns.Add(new DataColumn("Status", typeof(string)));
        dt.Columns.Add(new DataColumn("Created At", typeof(string)));
        dt.Columns.Add(new DataColumn("Updated At", typeof(string)));
        dt.Columns.Add(new DataColumn("Last Signin At", typeof(string)));
        dt.Columns.Add(new DataColumn("Edit", typeof(string)));
        dt.Columns.Add(new DataColumn("Change Password", typeof(string)));

        gvUsers.DataSource = _quotationTrackingSystemDBEntities.tblUsers.ToList();
        foreach (var x in _quotationTrackingSystemDBEntities.tblUsers.ToList())
        {
            dr = dt.NewRow();
            dr["First Name"] = x.FirstName;
            dr["Middle Name"] = x.MiddleName;
            dr["Last Name"] = x.LastName;
            dr["User Name"] = x.UserName;
            dr["Role"] = x.Role;
            dr["Status"] = x.Status;
            dr["Created At"] = DateTimeHelper.ConvertToString(x.CreatedAt.ToString());
            dr["Updated At"] = DateTimeHelper.ConvertToString(x.UpdatedAt.ToString());
            dr["Last Signin At"] = DateTimeHelper.ConvertToString(x.LastSignInAt.ToString());
            dr["Edit"] = x.Id;
            dr["Change Password"] = x.Id;
            dt.Rows.Add(dr);
        }

        gvUsers.DataSource = dt;
        gvUsers.DataBind();
    }

}