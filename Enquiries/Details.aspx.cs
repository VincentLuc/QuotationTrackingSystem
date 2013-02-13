using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Collections;

public partial class Enquiries_Details : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    public Enquiry enquiry;
    public string UnderWriterName;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack){
            hdnEnquiryId.Value = Request.QueryString["id"];
        }
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _currentUserId = CurrentUser.Id();
        var _enquiryId = int.Parse(hdnEnquiryId.Value);
        enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.CreatedBy == _currentUserId).Where(x => x.Id == _enquiryId).FirstOrDefault();
        if (enquiry == null) {
            Session["ErrorMessage"] = "You are not authorized to access that enquiry !";
            Response.Redirect("Index.aspx");
            return;
        }
        UnderWriterName = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == enquiry.UnderWriterId).FirstOrDefault().UserName;
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        var _currentUserId = CurrentUser.Id();
        var enquiryId = int.Parse(hdnEnquiryId.Value);
        var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.CreatedBy == _currentUserId).Where(x => x.Id == enquiryId).FirstOrDefault();
        sendFile(enquiry.CRCopyName, enquiry.CRCopyPath); 
    }

    protected void btnLossRatio_Click(object sender, EventArgs e)
    {
        var _currentUserId = CurrentUser.Id();
        var enquiryId = int.Parse(hdnEnquiryId.Value);
        var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.CreatedBy == _currentUserId).Where(x => x.Id == enquiryId).FirstOrDefault();
        sendFile(enquiry.PreviousLossRatioReportName, enquiry.PreviousLossRatioReportPath);
    }

    protected void btnAdditionalDocument_Click(object sender, EventArgs e)
    {
        var _currentUserId = CurrentUser.Id();
        var enquiryId = int.Parse(hdnEnquiryId.Value);
        var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.CreatedBy == _currentUserId).Where(x => x.Id == enquiryId).FirstOrDefault();
        sendFile(enquiry.AdditionalDocumentName, enquiry.AdditionalDocumentPath);
    }

    protected void btnQuotationDocument_Click(object sender, EventArgs e)
    {
        var _currentUserId = CurrentUser.Id();
        var enquiryId = int.Parse(hdnEnquiryId.Value);
        var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.CreatedBy == _currentUserId).Where(x => x.Id == enquiryId).FirstOrDefault();
        sendFile(enquiry.QuotationFileName, enquiry.QuotationFilePath);
    }

    protected void sendFile(string FileName, string FilePath) {
        System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
        response.ClearContent();
        response.Clear();
        response.ContentType = "text/plain";
        response.AddHeader("Content-Disposition", "attachment; filename=" + FileName + ";");
        response.TransmitFile(FilePath);
        response.Flush();
        response.End();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Hashtable hash = FileHelper.UpdateCommentFile(Request.Files["commentFile"], int.Parse(hdnEnquiryId.Value), "comment_file_");
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _currentUserId = CurrentUser.Id();
        var _currentUserName = User.Identity.Name;
        var _enquiryId = int.Parse(hdnEnquiryId.Value);
        var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.Id == _enquiryId).First();
        var _underWriterId = enquiry.UnderWriterId;
        var text = "New Comment on Enquiry. Commented By " + _currentUserName + " !";

        var comment = new Comment { Text = txtText.Text.Trim(), FileName = hash["fileName"].ToString(), FilePath = hash["filePath"].ToString(), CreatedAt = DateTime.Now, CreatedBy = _currentUserName, EnquiryId = _enquiryId };
        var notification = new Notification { IsRead = "False", UserId = _underWriterId, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, Text = text, EnquiryId = _enquiryId };

        _quotationTrackingSystemDBEntities.AddToNotifications(notification);
        _quotationTrackingSystemDBEntities.AddToComments(comment);
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully added comment!";
        Response.Redirect("Details.aspx?id=" + _enquiryId);
    }
}