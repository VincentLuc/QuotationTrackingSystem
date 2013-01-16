using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Web.Security;
using System.Data.Objects;

public partial class Account_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            errorDiv.Visible = false;
        }
        if (User.Identity.IsAuthenticated && Request.QueryString["ReturnUrl"] != null)
        {
            Response.Redirect("/QuotationTrackingSystem/NotAuthorized.aspx");
        }
        else if (User.Identity.IsAuthenticated)
        {
            Response.Redirect(CurrentUser.GetRedirectPath(CurrentUser.Role()));
        }    
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var encodedPassword = StringHelper.MD5Hash(txtPassword.Text);
        var user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.UserName == txtUserName.Text).Where(x => x.Password == encodedPassword).Where(x => x.Status == "Active").FirstOrDefault();
        if (user == null) {
            errorDiv.Visible = true;
            return;
        }
        FormsAuthentication.SetAuthCookie(user.UserName, false);
        FormsAuthenticationTicket ticket1 =
           new FormsAuthenticationTicket(
                1,                                   // version
                user.UserName,   // get username  from the form
                DateTime.Now,                        // issue time is now
                DateTime.Now.AddHours(11),         // expires in 10 minutes
                false,      // cookie is not persistent
                user.Role + "#" + user.Id.ToString()    // role assignment is stored
                );
        HttpCookie cookie1 = new HttpCookie(
          FormsAuthentication.FormsCookieName,
          FormsAuthentication.Encrypt(ticket1));
        Response.Cookies.Add(cookie1);
        int? count = user.SignInCount.Equals(String.Empty) ? 0 : user.SignInCount;
        user.SignInCount = count + 1;
        user.LastSignInAt = DateTime.Now;
        _quotationTrackingSystemDBEntities.SaveChanges();
        String returnUrl1 = "";
        if (Request.QueryString["ReturnUrl"] != null)
        {
            returnUrl1 = Request.QueryString["ReturnUrl"];
        }
        else
        {
            returnUrl1 = CurrentUser.GetRedirectPath(user.Role);
        }
        Session["NoticeMessage"] = "Successfully logged in !";
        Response.Redirect(returnUrl1);
    }
}
