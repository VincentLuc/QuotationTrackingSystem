using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Collections;

public partial class Enquiries_RerspondToMissingInformation : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected Enquiry enquiry;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            hdnEnquiryId.Value = Request.QueryString["id"];
            _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
            var _currentUserId = CurrentUser.Id();
            var _enquiryId = int.Parse(hdnEnquiryId.Value);
            enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.CreatedBy == _currentUserId).Where(x => x.Id == _enquiryId).FirstOrDefault();
            if (enquiry == null)
            {
                Session["ErrorMessage"] = "You are not authorized to access that enquiry !";
                Response.Redirect("Index.aspx");
                return;
            }
            var canUpdate = CanUpdateInformation(enquiry);
            if (!canUpdate) {
                return;
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        var _enquiryId = int.Parse(hdnEnquiryId.Value);
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.Id == _enquiryId).First();

        var canUpdate = CanUpdateInformation(enquiry);
        if (!canUpdate){
            return;
        }

        var _currentUserName = User.Identity.Name;
        var underwriterId = enquiry.UnderWriterId;
        var text = "Enquiry Information Updated. Updated By " + _currentUserName + " !";
        var commentText = "Informarmation Update - " + txtText.Text.Trim();

        EnquiryHelper.SendNotifications(_quotationTrackingSystemDBEntities, enquiry, _currentUserName, text, false);
        var newEvent = new Event { State = "InformationUpdate", CreatedBy = _currentUserName, CreatedAt = DateTime.Now, EnquiryId = _enquiryId };
        enquiry.UpdatedAt = DateTime.Now;
        enquiry.Status = "InformationUpdate";
        _quotationTrackingSystemDBEntities.AddToEvents(newEvent);
        _quotationTrackingSystemDBEntities.SaveChanges();

        Hashtable hash = FileHelper.UpdateCommentFile(Request.Files["commentFile"], int.Parse(hdnEnquiryId.Value), "comment_file_");
        var comment = new Comment { Text = commentText, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, EnquiryId = _enquiryId, EventId = newEvent.Id, FileName = hash["fileName"].ToString(), FilePath = hash["filePath"].ToString() };
        _quotationTrackingSystemDBEntities.AddToComments(comment);
        _quotationTrackingSystemDBEntities.SaveChanges();
        Response.Redirect("Details.aspx?id=" + _enquiryId);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Details.aspx?id=" + hdnEnquiryId.Value);
    }

    protected bool CanUpdateInformation(Enquiry enquiry) {
        var canUpdate = true;
        if (enquiry.Status != "MissingInformation" && enquiry.Status != "AdditionalInformation")
        {
            canUpdate = false;
            Session["ErrorMessage"] = "Now you cannot update enquiry status !";
            Response.Redirect("Details.aspx?id=" + hdnEnquiryId.Value);
        }
        return canUpdate;
    }
}