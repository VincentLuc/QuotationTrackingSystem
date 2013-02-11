using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class Emails_Details : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    public Email email;
    protected void Page_Load(object sender, EventArgs e)
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _currentUserId = CurrentUser.Id();
        var _emailId = int.Parse(Request.QueryString["id"]);
        email = _quotationTrackingSystemDBEntities.Emails.Where(x => x.UserId == _currentUserId).Where(x => x.Id == _emailId).FirstOrDefault();
        if (email == null) {
            Session["ErrorMessage"] = "You are not authorized to access that email !";
            Response.Redirect("Inbox.aspx");
            return;
        }
        if (email.IsRead == "False") {
            email.IsRead = "True";
            _quotationTrackingSystemDBEntities.SaveChanges();
        }
    }
}