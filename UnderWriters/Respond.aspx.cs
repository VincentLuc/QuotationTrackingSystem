using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using QuotationTrackingSystemDBModel;
using System.Collections;

public partial class UnderWriters_Respond : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            declinedDiv.Visible = false;
            rfvText.Enabled = false;
            hdnEnquiryId.Value = Request.QueryString["id"];
            var _enquiryId = int.Parse(hdnEnquiryId.Value);
            var _currentUserId = CurrentUser.Id();
            _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
            var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.Id == _enquiryId).Where(x => x.UnderWriterId == _currentUserId).FirstOrDefault();
            if (enquiry == null){
                Session["ErrorMessage"] = "You are not authorized to access that enquiry !";
                Response.Redirect("Enquiries.aspx");
                return;
            }
            var canUpdate = CanUpdateEnquiry(enquiry);
            if (!canUpdate) {
                return;
            }
        }
    }
    
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlStatus.SelectedValue == "Release Quotation")
        {
            rfvText.Enabled = false;
            declinedDiv.Visible = false;
            quotationDiv.Visible = true;
        }
        else {
            rfvText.Enabled = true;
            declinedDiv.Visible = true;
            quotationDiv.Visible = false;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlStatus.SelectedValue == "Release Quotation" && (Request.Files["quotationFile"] == null || Request.Files["quotationFile"].ContentLength <= 0 )){
            Session["ErrorMessage"] = "Please Attach Quotation File!";
            return;
        }
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _currentUserName = User.Identity.Name;
        var _enquiryId = int.Parse(hdnEnquiryId.Value);
        var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.Id == _enquiryId).First();
        var salesPersonId = enquiry.CreatedBy;
        var text = "Enquiry " + StringHelper.ToSentenceCase(ddlStatus.SelectedValue.ToString()) + ". Updated By " + _currentUserName + " !";
        var commentText = StringHelper.ToSentenceCase(ddlStatus.SelectedValue.ToString()) + " - " + txtText.Text.Trim();
        var _enquiryStatus = ddlStatus.SelectedValue.ToString(); ;

        var canUpdate = CanUpdateEnquiry(enquiry);
        if (!canUpdate) {
            return;
        }

        enquiry.Status = ddlStatus.SelectedValue;
        _enquiryStatus = ddlStatus.SelectedValue;
        if (ddlStatus.SelectedValue == "Release Quotation")
        {
            Hashtable hash = FileHelper.UpdateCommentFile(Request.Files["quotationFile"], int.Parse(hdnEnquiryId.Value), "quotation_file_");
            enquiry.QuotationFileName = hash["fileName"].ToString();
            enquiry.QuotationFilePath = hash["filePath"].ToString();
        }

        EnquiryHelper.SendNotifications(_quotationTrackingSystemDBEntities, enquiry, _currentUserName, text, true);
        var newEvent = new Event { State = _enquiryStatus, CreatedBy = _currentUserName, CreatedAt = DateTime.Now, EnquiryId = _enquiryId };

        _quotationTrackingSystemDBEntities.AddToEvents(newEvent);
        _quotationTrackingSystemDBEntities.SaveChanges();

        if (ddlStatus.SelectedValue != "Release Quotation"){
            var comment = new Comment { Text = commentText, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, EnquiryId = _enquiryId, EventId = newEvent.Id };
            _quotationTrackingSystemDBEntities.AddToComments(comment);
            _quotationTrackingSystemDBEntities.SaveChanges();
        }

        Session["NoticeMessage"] = "Successfully updated enquiry!";
        Response.Redirect("EnquiryDetails.aspx?id=" + _enquiryId);

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("EnquiryDetails.aspx?id=" + hdnEnquiryId.Value);
    }

    public bool CanUpdateEnquiry(Enquiry enquiry) {
        var canUpdate = true;
        if (enquiry.Status != "New" && enquiry.Status != "UnderWriterViewed" && enquiry.Status != "InformationUpdate") {
            canUpdate = false;
            Session["ErrorMessage"] = "Now you cannot update enquiry status !";
            Response.Redirect("EnquiryDetails.aspx?id=" + hdnEnquiryId.Value);
        }
        return canUpdate;
    }
}