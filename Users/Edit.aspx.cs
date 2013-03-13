using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class Users_Edit : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            hdnFldUserId.Value = Request.QueryString["id"];
            _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
            int Id = int.Parse(Request.QueryString["id"].ToString());
            var Count = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == Id).Count();
            if (Count == 0)
            {
                Session["ErrorMessage"] = "User does not exists in the system!";
                Response.Redirect("Index.aspx");
            }
            var user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == Id).First();
            txtFirstName.Text = user.FirstName;
            txtMiddleName.Text = user.MiddleName;
            txtLastName.Text = user.LastName;
            txtUserName.Text = user.UserName;
            ddlRole.SelectedValue = user.Role;
            ddlStatus.SelectedValue = user.Status;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int Id = int.Parse(hdnFldUserId.Value);
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
        user.UserName = txtUserName.Text.Trim();
        user.Role = ddlRole.SelectedValue;
        user.Status = ddlStatus.SelectedValue;
        user.UpdatedAt = DateTime.Now;
        
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully updated the user!";
        Response.Redirect("Index.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Index.aspx");
    }

}