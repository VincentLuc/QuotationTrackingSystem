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
        _enquiry = new Enquiry { ClientName = txtClientName.Text, ContactPersonName = txtContactPersonName.Text, Phone = txtPhone.Text, InsuranceType = ddlInuranceType.SelectedValue, PolicyStartAt = _policyStartAt, Status = "Created", Address = txtAddress.Text, Remarks = txtRemarks.Text, CreatedBy = _currentUserID, UnderWriterId = _underWriterId, CreatedAt = _createdAt, UpdatedAt = _createdAt };
        var _currentUserName = User.Identity.Name;
        _event = new Event { State = "Created", CreatedAt = _createdAt, CreatedBy = _currentUserName };
        _enquiry.Events.Add(_event);
        _quotationTrackingSystemDBEntities.AddToEnquiries(_enquiry);
        _quotationTrackingSystemDBEntities.SaveChanges();

        HttpPostedFile lossRatioFile = Request.Files["fileLossRatioReport"];
        Hashtable hash = GetFilesDetails(fileCRCopy, lossRatioFile, _enquiry);
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

    public Hashtable GetFilesDetails(HttpPostedFile crFile, HttpPostedFile lossRatioFilex, Enquiry enquiry) {
        var _timeStamp = DateTimeHelper.ToTimeStamp();
        var path = FileHelper.GetEnquiryFolderPath(enquiry.Id);
        var _CRFileName = "cr_file_" + _timeStamp + "_" + Path.GetFileName(crFile.FileName);
        var _CRFilePath = path + "\\" + _CRFileName;
        crFile.SaveAs(_CRFilePath);

        var _lossRatioFileName = "";
        var _lossRatioFilePath = "";

        if (lossRatioFilex != null && lossRatioFilex.ContentLength > 0){
            _lossRatioFileName = "loss_ratio_" + _timeStamp + "_" + Path.GetFileName(lossRatioFilex.FileName);
            _lossRatioFilePath = path + "\\" + _lossRatioFileName ;
            lossRatioFilex.SaveAs(_lossRatioFilePath);
        }
        Hashtable _hash = new Hashtable();
        _hash.Add("CRFileName", _CRFileName);
        _hash.Add("CRFilePath", _CRFilePath);
        _hash.Add("LossRatioFileName", _lossRatioFileName);
        _hash.Add("LossRatioFilePath", _lossRatioFilePath);
        return _hash;
    }
}