using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class Visits_Edit : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            hdnVisitId.Value = Request.QueryString["id"];
            var VisitId = int.Parse(Request.QueryString["id"]);
            _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
            Visit _visit = _quotationTrackingSystemDBEntities.Visits.Where(x => x.Id == VisitId).First();
            if (_visit.UserId != CurrentUser.Id()) { 
                Session["ErrorMessage"] = "You are not authorized to edit that visit data !";
                Response.Redirect("Index.aspx");
                return;
            }
            txtClientName.Text = _visit.ClientName;
            txtContactPerson.Text = _visit.ContactPerson;
            txtDesignation.Text = _visit.Designation;
            txtPhone.Text = _visit.Phone;
            ddlLineOfInsurance.SelectedValue = _visit.LineOfInsurance;
            ddlStatus.SelectedValue = _visit.Status;
            txtPolicyStartAt.Text = DateTimeHelper.ConvertToString(_visit.PolicyStartAt.ToString());
            txtRemarks.Text = _visit.Remarks;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        var VisitId = int.Parse(hdnVisitId.Value);
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        Visit _visit = _quotationTrackingSystemDBEntities.Visits.Where(x => x.Id == VisitId).First();
        _visit.ClientName = txtClientName.Text;
        _visit.ContactPerson = txtContactPerson.Text;
        _visit.Designation = txtDesignation.Text;
        _visit.Phone = txtPhone.Text;
        _visit.LineOfInsurance = ddlLineOfInsurance.SelectedValue;
        _visit.Status = ddlStatus.SelectedValue;
        _visit.Remarks = txtRemarks.Text;
        _visit.UpdatedAt = DateTime.Now;
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully updated visit data !";
        Response.Redirect("Index.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Index.aspx");
    }
}