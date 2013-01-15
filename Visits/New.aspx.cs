using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class Visits_New : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            txtPolicyStartAt.Text = DateTimeHelper.ConvertToString(DateTime.Now.ToString());
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var user = CurrentUser.DbUser();
        Visit _visit = new Visit();
        _visit.ClientName = txtClientName.Text;
        _visit.ContactPerson = txtContactPerson.Text;
        _visit.Designation = txtDesignation.Text;
        _visit.Phone = txtPhone.Text;
        _visit.LineOfInsurance = ddlLineOfInsurance.SelectedValue;
        _visit.PolicyStartAt = DateTimeHelper.ConvertToDateWithoutNull(txtPolicyStartAt.Text);
        _visit.Status = ddlStatus.SelectedValue;
        _visit.Remarks = txtRemarks.Text;
        _visit.UserId = user.Id;
        _visit.CreatedAt = DateTime.Now;
        _visit.UpdatedAt = DateTime.Now;
        _quotationTrackingSystemDBEntities.AddToVisits(_visit);
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully created new visit data !";
        Response.Redirect("Index.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Index.aspx");
    }
}