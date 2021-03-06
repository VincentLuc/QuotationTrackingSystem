﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class CurrentUser_ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var Id = CurrentUser.Id();
        var user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == Id).First();
        var encodedCurrentPassword = StringHelper.MD5Hash(txtCurrentPassword.Text.Trim());
        if (user.Password != encodedCurrentPassword) {
            Session["ErrorMessage"] = "Your Current Password is Incorrect !";
            return;
        }
        user.Password = StringHelper.MD5Hash(txtPassword.Text);
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully updated your password !";
        Response.Redirect(CurrentUser.GetRedirectPath(CurrentUser.Role()));
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(CurrentUser.GetRedirectPath(CurrentUser.Role()));
    }
}