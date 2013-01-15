using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class Users_NewSalesUser : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected tblUser SupervisorUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            hdnFldUserRole.Value = "Sales";
            hdnSalesSupervisorId.Value = Request.QueryString["SupervisorId"];
        }
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        int SuperVisorId = int.Parse(hdnSalesSupervisorId.Value.ToString());
        SupervisorUser = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == SuperVisorId).First();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var count = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.UserName.ToLower() == txtUserName.Text.Trim().ToLower()).Count();
        if (count != 0)
        {
            Session["ErrorMessage"] = "User name already exists in the system!";
            return;
        }
        tblUser user = new tblUser();
        user.FirstName = txtFirstName.Text.Trim();
        user.MiddleName = txtMiddleName.Text.Trim();
        user.LastName = txtLastName.Text.Trim();
        user.UserName = txtUserName.Text.Trim();
        user.Password = StringHelper.MD5Hash(txtPassword.Text.Trim());
        user.Role = hdnFldUserRole.Value;
        user.SupervisorId = int.Parse(hdnSalesSupervisorId.Value);
        user.Status = ddlStatus.SelectedValue;
        user.CreatedAt = DateTime.Now;
        user.UpdatedAt = DateTime.Now;
        user.SignInCount = 0;
        _quotationTrackingSystemDBEntities.AddTotblUsers(user);
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully created new sales user!";
        Response.Redirect("Details.aspx?id="+hdnSalesSupervisorId.Value);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Details.aspx?id=" + hdnSalesSupervisorId.Value);
    }

}