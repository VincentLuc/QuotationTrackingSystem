using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class MyAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) { 
            QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
            var Id = CurrentUser.Id();
            var user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == Id).First();
            txtFirstName.Text = user.FirstName;
            txtMiddleName.Text = user.MiddleName;
            txtLastName.Text = user.LastName;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var Id = CurrentUser.Id();
        var user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == Id).First();
        user.FirstName = txtFirstName.Text;
        user.MiddleName = txtMiddleName.Text;
        user.LastName = txtLastName.Text;
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully updated your account information !";
        Response.Redirect(CurrentUser.GetRedirectPath(CurrentUser.Role()));
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(CurrentUser.GetRedirectPath(CurrentUser.Role()));
    }
}