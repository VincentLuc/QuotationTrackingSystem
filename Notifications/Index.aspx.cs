﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class Notifications_Index : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        BindDataToGridView();
    }
    protected void gvNotifications_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvNotifications.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }
    protected void gvNotifications_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;

        LinkButton lb;
        lb = new LinkButton();
        var cell_3 = e.Row.Cells[3];
        var array = cell_3.Text.Split('#');
        e.Row.CssClass = array[1] == "True" ? "read" : "unread";
        lb.CommandArgument = array[0];
        lb.CommandName = "NumClick";
        lb.Text = array[0];
        lb.PostBackUrl = "/QuotationTrackingSystem/UnderWriters/EnquiryDetails.aspx?id=" + array[0];
        cell_3.Controls.Add((Control)lb);

        if (array[1] == "False")
        {
            Button btn = new Button();
            btn.Text = "Mark as read";
            btn.CommandArgument = array[2];
            btn.CssClass = "btn";
            btn.Click += new EventHandler(btn_Clicked);
            e.Row.Cells[4].Controls.Add(btn);
        }
    }

    protected void btn_Clicked(object sender, System.EventArgs e)
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var notificationId = int.Parse(((Button)sender).CommandArgument.ToString());
        var notification = _quotationTrackingSystemDBEntities.Notifications.Where(x => x.Id == notificationId).First();
        notification.IsRead = "True";
        _quotationTrackingSystemDBEntities.SaveChanges();
        ((Button)sender).Visible = false;
    }

    protected void BindDataToGridView()
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("Notification On", typeof(string)));
        dt.Columns.Add(new DataColumn("Notification By", typeof(string)));
        dt.Columns.Add(new DataColumn("Text", typeof(string)));
        dt.Columns.Add(new DataColumn("Enquiry Id", typeof(string)));
        dt.Columns.Add(new DataColumn("Read?", typeof(string)));

        var _currentUserId = CurrentUser.Id();
        foreach (var x in _quotationTrackingSystemDBEntities.Notifications.Where(x => x.UserId == _currentUserId).OrderByDescending(x => x.CreatedAt).ToList())
        {
            dr = dt.NewRow();
            dr["Notification On"] = DateTimeHelper.To24Hours(x.CreatedAt);
            dr["Notification By"] = x.CreatedBy;
            dr["Text"] = x.Text;
            dr["Enquiry Id"] = x.EnquiryId + "#" + x.IsRead + "#" + x.Id;
            dt.Rows.Add(dr);
        }

        gvNotifications.DataSource = dt;
        gvNotifications.DataBind();
    }

}