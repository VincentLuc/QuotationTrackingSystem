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
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected Enquiry _enquiry;
    protected Event _event;
    protected Notification _notification;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            corporate.Visible = false;
            rbtnInsurance.SelectedValue = "Individual";
        }
        hdnCurrentUserId.Value = CurrentUser.Id().ToString();
    }

    protected void rbtnInsurance_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rbtnInsurance.SelectedValue == "Individual"){
            individual.Visible = true;
            rfvNationalIdOrIqamaNumber.Enabled = true;
            corporate.Visible = false;
            rfvCRNumber.Enabled = false;
            txtNationalIdOrIqamaNumber.Text = "";
        }else {
            individual.Visible = false;
            rfvNationalIdOrIqamaNumber.Enabled = false;
            corporate.Visible = true;
            rfvCRNumber.Enabled = true;
            txtCrNumber.Text = "";
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        HttpPostedFile fileCRCopy = Request.Files["fileCRCopy"];
        if (fileCRCopy == null || fileCRCopy.ContentLength <= 0) {
          Session["ErrorMessage"] = "CR copy is required !";
          return;
        }
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _policyStartAt = DateTimeHelper.ConvertToDate(txtIntendedPolicyStartAt.Text);
        var _currentUserID = CurrentUser.Id();
        var _createdAt = DateTime.Now;
        var _underWriterId = int.Parse(ddlUnderwriterId.SelectedValue);
        var lossRatioOne = NumberHelper.ConvertToDecimal(txtLossRatioOne.Text);
        var lossRatioTwo = NumberHelper.ConvertToDecimal(txtLossRatioTwo.Text);
        var lossRatioThree = NumberHelper.ConvertToDecimal(txtLossRatioThree.Text);
        var expectedPremium = decimal.Parse(txtExpectedPremium.Text.Trim());
        _enquiry = new Enquiry { ClientName = txtClientName.Text, ContactPersonName = txtContactPersonName.Text, Phone1 = txtPhone1.Text, Phone2 = txtPhone2.Text, InsuranceType = ddlInsuranceType.SelectedValue, IntendedPolicyStartAt = _policyStartAt, InsuranceFor = rbtnInsurance.SelectedValue, Status = "New", Address = txtAddress.Text, Remarks = txtRemarks.Text, CreatedBy = _currentUserID, UnderWriterId = _underWriterId, CreatedAt = _createdAt, UpdatedAt = _createdAt, ExpectedPremium = expectedPremium, LossRatioOne = lossRatioOne, LossRatioTwo = lossRatioTwo, LossRatioThree = lossRatioThree };
        if (_enquiry.InsuranceFor == "Individual") {
            _enquiry.NationalIdOrIqamaNumber = txtNationalIdOrIqamaNumber.Text;
        } else {
            _enquiry.CRNumber = txtCrNumber.Text;
        }
        var _currentUserName = User.Identity.Name;
        _event = new Event { State = "New", CreatedAt = _createdAt, CreatedBy = _currentUserName };
        var text = "New Enquiry Created By " + _currentUserName + " !";
        _notification = new Notification { IsRead = "False", UserId = _underWriterId, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, Text = text };
        _enquiry.Events.Add(_event);
        _enquiry.Notifications.Add(_notification);
        _quotationTrackingSystemDBEntities.AddToEnquiries(_enquiry);
        _quotationTrackingSystemDBEntities.SaveChanges();

        EnquiryUser _enquiryUser;

        foreach (ListItem item in lstbxCopySales.Items) {
            if(item.Selected){
              int salesUserId = int.Parse(item.Value);
              _notification = new Notification { IsRead = "False", UserId = salesUserId, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, Text = text, EnquiryId = _enquiry.Id };
              _enquiryUser = new EnquiryUser { UserId = salesUserId, EnquiryId = _enquiry.Id };
              _quotationTrackingSystemDBEntities.AddToNotifications(_notification);
              _quotationTrackingSystemDBEntities.AddToEnquiryUsers(_enquiryUser);
            }
        }

        foreach (ListItem item in lstbxCopyUnderwriters.Items)
        {
            if (item.Selected)
            {
                int underwriterId = int.Parse(item.Value);
                _notification = new Notification { IsRead = "False", UserId = underwriterId, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, Text = text, EnquiryId = _enquiry.Id };
                _enquiryUser = new EnquiryUser { UserId = underwriterId, EnquiryId = _enquiry.Id };
                _quotationTrackingSystemDBEntities.AddToNotifications(_notification);
                _quotationTrackingSystemDBEntities.AddToEnquiryUsers(_enquiryUser);
            }
        }

        HttpPostedFile lossRatioFile = Request.Files["filePreviousLossRatioReport"];
        HttpPostedFile additionalDocumentFile = Request.Files["fileAdditionalDocuments"];

        Hashtable hash = FileHelper.GetFilesDetails(fileCRCopy, lossRatioFile, additionalDocumentFile, _enquiry);
        _enquiry.CRCopyName = hash["CRFileName"].ToString();
        _enquiry.CRCopyPath = hash["CRFilePath"].ToString();
        _enquiry.PreviousLossRatioReportName = hash["PreviousLossRatioFileName"].ToString();
        _enquiry.PreviousLossRatioReportPath = hash["PreviousLossRatioFilePath"].ToString();
        _enquiry.AdditionalDocumentName = hash["AdditionalFileName"].ToString();
        _enquiry.AdditionalDocumentPath = hash["AdditionalFilePath"].ToString();
        _quotationTrackingSystemDBEntities.SaveChanges();

        Session["NoticeMessage"] = "Successfully created enquiry and submitted to under writer !";
        Response.Redirect("Index.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Index.aspx");
    }
  
}