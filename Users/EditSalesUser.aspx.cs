using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class Users_EditSalesUser : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected tblUser SupervisorUser;
    protected tblUser SalesUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        int SalesUserId = int.Parse(Request.QueryString["SalesUserId"]);
        SalesUser = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == SalesUserId).First();
        if (!IsPostBack)
        {
            hdnSalesSupervisorId.Value = Request.QueryString["SupervisorId"];
            hdnFldSalesUser.Value = SalesUserId.ToString();
            txtFirstName.Text = SalesUser.FirstName;
            txtMiddleName.Text = SalesUser.MiddleName;
            txtLastName.Text = SalesUser.LastName;
            ddlStatus.SelectedValue = SalesUser.Status;
            txtUserName.Text = SalesUser.UserName;
        }
        int SuperVisorId = int.Parse(hdnSalesSupervisorId.Value.ToString());
        SupervisorUser = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == SuperVisorId).First();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int Id = int.Parse(hdnFldSalesUser.Value);
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == Id).First();

        var count = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.UserName == txtUserName.Text.Trim()).Count();
        if (count != 0 && user.UserName.ToLower() != txtUserName.Text.Trim().ToLower())
        {
            Session["ErrorMessage"] = "User name already exists in the system!";
            return;
        }
        user.FirstName = txtFirstName.Text.Trim();
        user.MiddleName = txtMiddleName.Text.Trim();
        user.LastName = txtLastName.Text.Trim();
        user.Status = ddlStatus.SelectedValue;
        user.UserName = txtUserName.Text.Trim();
        user.UpdatedAt = DateTime.Now;

        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully updated the sales user!";
        Response.Redirect("Details.aspx?id="+user.SupervisorId);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Details.aspx?id=" + hdnSalesSupervisorId);
    }
}