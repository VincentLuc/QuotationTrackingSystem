using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.IO;
using System.Collections;

public partial class Enquiries_New : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    Enquiry _enquiry;
    Event _event;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        HttpPostedFile fileCRCopy = Request.Files["fileCRCopy"];
        if (fileCRCopy == null || fileCRCopy.ContentLength <= 0) {
          Session["ErrorMessage"] = "CR copy is required !";
          return;
        }
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _policyStartAt = DateTimeHelper.ConvertToDate(txtPolicyStartAt.Text);
        var _currentUserID = CurrentUser.Id();
        var _createdAt = DateTime.Now;
        var _underWriterId = int.Parse(ddlUnderwriterId.SelectedValue);
        _enquiry = new Enquiry { ClientName = txtClientName.Text, ContactPersonName = txtContactPersonName.Text, Phone = txtPhone.Text, InsuranceType = ddlInsuranceType.SelectedValue, PolicyStartAt = _policyStartAt, Status = "Created", Address = txtAddress.Text, Remarks = txtRemarks.Text, CreatedBy = _currentUserID, UnderWriterId = _underWriterId, CreatedAt = _createdAt, UpdatedAt = _createdAt };
        var _currentUserName = User.Identity.Name;
        _event = new Event { State = "Created", CreatedAt = _createdAt, CreatedBy = _currentUserName };
        _enquiry.Events.Add(_event);
        _quotationTrackingSystemDBEntities.AddToEnquiries(_enquiry);
        _quotationTrackingSystemDBEntities.SaveChanges();

        HttpPostedFile lossRatioFile = Request.Files["fileLossRatioReport"];

        Hashtable hash = FileHelper.GetFilesDetails(fileCRCopy, lossRatioFile, _enquiry);
        _enquiry.CRCopyName = hash["CRFileName"].ToString();
        _enquiry.CRCopyPath = hash["CRFilePath"].ToString();
        _enquiry.LossRatioReportName = hash["LossRatioFileName"].ToString();
        _enquiry.LossRatioReportPath = hash["LossRatioFilePath"].ToString();
        _quotationTrackingSystemDBEntities.SaveChanges();

        Session["NoticeMessage"] = "Successfully created enquiry and submitted to under writer !";
        Response.Redirect("Index.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Index.aspx");
    }
}