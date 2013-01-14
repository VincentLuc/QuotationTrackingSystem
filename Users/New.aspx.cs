using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq;
using QuotationTrackingSystemDBModel;

public partial class Users_New : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var count = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.UserName.ToLower() == txtUserName.Text.Trim().ToLower()).Count();
        if (count != 0) {
            Session["ErrorMessage"] = "User name already exists in the system!";
            return;
        }
        tblUser user = new tblUser();
        user.FirstName = txtFirstName.Text.Trim();
        user.MiddleName = txtMiddleName.Text.Trim();
        user.LastName = txtLastName.Text.Trim();
        user.UserName = txtUserName.Text.Trim();
        user.Password = StringHelper.MD5Hash(txtPassword.Text.Trim());
        user.Role = ddlRole.SelectedValue;
        user.Status = ddlStatus.SelectedValue;
        user.CreatedAt = DateTime.Now;
        user.UpdatedAt = DateTime.Now;
        user.SignInCount = 0;
        _quotationTrackingSystemDBEntities.AddTotblUsers(user);
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully created new user!";
        Response.Redirect("Index.aspx");
    }
    protected void btnCacnel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Index.aspx");
    }
}