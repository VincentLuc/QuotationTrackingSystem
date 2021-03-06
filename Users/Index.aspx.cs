﻿using System;
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
        lb.CommandArgument = e.Row.Cells[4].Text;
        lb.CommandName = "NumClick";
        lb.Text = "Edit";
        lb.PostBackUrl = "~/Users/Edit.aspx?id=" + e.Row.Cells[4].Text;
        e.Row.Cells[4].Controls.Add((Control)lb);

        LinkButton lb1 = new LinkButton();
        lb1.CommandArgument = e.Row.Cells[5].Text;
        lb1.CommandName = "NumClick";
        lb1.Text = "Change Password";
        lb1.PostBackUrl = "~/Users/ChangePassword.aspx?id=" + e.Row.Cells[5].Text;
        e.Row.Cells[5].Controls.Add((Control)lb1);

        LinkButton lb2 = new LinkButton();
        lb2.CommandArgument = e.Row.Cells[6].Text;
        lb2.CommandName = "NumClick";
        lb2.Text = "Details";
        lb2.PostBackUrl = "~/Users/Details.aspx?id=" + e.Row.Cells[6].Text;
        e.Row.Cells[6].Controls.Add((Control)lb2);

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

        dt.Columns.Add(new DataColumn("User Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Role", typeof(string)));
        dt.Columns.Add(new DataColumn("Status", typeof(string)));
        dt.Columns.Add(new DataColumn("Created At", typeof(string)));
        dt.Columns.Add(new DataColumn("Edit", typeof(string)));
        dt.Columns.Add(new DataColumn("Change Password", typeof(string)));
        dt.Columns.Add(new DataColumn("Details", typeof(string)));

        foreach (var x in _quotationTrackingSystemDBEntities.tblUsers.ToList())
        {
            dr = dt.NewRow();
            dr["User Name"] = x.UserName;
            dr["Role"] = StringHelper.ToSentenceCase(x.Role);
            dr["Status"] = x.Status;
            dr["Created At"] = DateTimeHelper.ConvertToString(x.CreatedAt.ToString());
            dr["Edit"] = x.Id;
            dr["Change Password"] = x.Id;
            dr["Details"] = x.Id;
            dt.Rows.Add(dr);
        }

        gvUsers.DataSource = dt;
        gvUsers.DataBind();
    }

}