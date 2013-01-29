using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

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
        UnderWriterName = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == enquiry.UnderWriterId).FirstOrDefault().UserName;
        if (enquiry == null) {
            Session["ErrorMessage"] = "Enquiry not found !";
            Response.Redirect("Index.aspx");
            return;
        }
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
        sendFile(enquiry.LossRatioReportName, enquiry.LossRatioReportPath);
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

}