using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class Users_ChangePassword : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
            int Id = int.Parse(Request.QueryString["id"].ToString());
            hdnFldUserId.Value = Id.ToString();
            var Count = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == Id).Count();
            if (Count == 0)
            {
                Session["ErrorMessage"] = "User does not exists in the system!";
                Response.Redirect("Index.aspx");
            }
            lblUserName.Text = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == Id).First().UserName;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int Id = int.Parse(hdnFldUserId.Value.ToString());
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == Id).First();
        user.Password = StringHelper.MD5Hash(txtPassword.Text);
        user.UpdatedAt = DateTime.Now;
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully changed password!";
        Response.Redirect("Index.aspx");
    }
    protected void btnCacnel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Index.aspx");
    }
}