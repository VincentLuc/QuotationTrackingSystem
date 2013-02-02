using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class UnderWriters_EnquiryDetails : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    public Enquiry enquiry;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack){
            hdnEnquiryId.Value = Request.QueryString["id"];
        }
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _enquiryId = int.Parse(hdnEnquiryId.Value);
        var _currentUserId = CurrentUser.Id();
        enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.Id == _enquiryId).Where(x => x.UnderWriterId == _currentUserId).FirstOrDefault();
        if (enquiry == null) {
            Session["ErrorMessage"] = "Enquiry not found !";
            Response.Redirect("Enquiries.aspx");
        }
        var enquiryEvent = enquiry.Events.Where(x => x.State == "UnderWriterViewed").FirstOrDefault();
        if (enquiryEvent == null) { 
            var userName = User.Identity.Name;
            var newEvent = new Event { State = "UnderWriterViewed", CreatedBy = userName, CreatedAt = DateTime.Now, EnquiryId = enquiry.Id };
            _quotationTrackingSystemDBEntities.AddToEvents(newEvent);
            _quotationTrackingSystemDBEntities.SaveChanges();
        }
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        var _currentUserId = CurrentUser.Id();
        var enquiryId = int.Parse(hdnEnquiryId.Value);
        var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.UnderWriterId == _currentUserId).Where(x => x.Id == enquiryId).FirstOrDefault();
        sendFile(enquiry.CRCopyName, enquiry.CRCopyPath); 
    }
    protected void btnLossRatio_Click(object sender, EventArgs e)
    {
        var _currentUserId = CurrentUser.Id();
        var enquiryId = int.Parse(hdnEnquiryId.Value);
        var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.UnderWriterId == _currentUserId).Where(x => x.Id == enquiryId).FirstOrDefault();
        sendFile(enquiry.PreviousLossRatioReportName, enquiry.PreviousLossRatioReportPath);
    }

    protected void btnAdditionalDocument_Click(object sender, EventArgs e)
    {
        var _currentUserId = CurrentUser.Id();
        var enquiryId = int.Parse(hdnEnquiryId.Value);
        var enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.UnderWriterId == _currentUserId).Where(x => x.Id == enquiryId).FirstOrDefault();
        sendFile(enquiry.AdditionalDocumentName, enquiry.AdditionalDocumentPath);
    }

    protected void sendFile(string FileName, string FilePath)
    {
        System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
        response.ClearContent();
        response.Clear();
        response.ContentType = "text/plain";
        response.AddHeader("Content-Disposition", "attachment; filename=" + FileName + ";");
        response.TransmitFile(FilePath);
        response.Flush();
        response.End();
    }
    
}