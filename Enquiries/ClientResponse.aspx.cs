﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Collections;

public partial class Enquiries_ClientResponse : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected Enquiry enquiry;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
            confirmationDiv.Visible = true;
            declinedDiv.Visible = true;
            rfvText.Enabled = false;
            hdnEnquiryId.Value = Request.QueryString["id"];
            var _currentUserId = CurrentUser.Id();
            var _enquiryId = int.Parse(hdnEnquiryId.Value);
            enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.CreatedBy == _currentUserId).Where(x => x.Id == _enquiryId).FirstOrDefault();
            if (enquiry == null || enquiry.Status != "QuotationReleased")
            {
                Session["ErrorMessage"] = enquiry == null ?  "You are not authorized to access that enquiry!" : "Enquiry state cannot be changed now!" ;
                Response.Redirect("Index.aspx");
                return;
            }
        }
    }
    protected void ddlResponse_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlResponse.SelectedValue == "ClientAccepted") {
            confirmationDiv.Visible = true;
            rfvText.Enabled = false;
        } else {
            confirmationDiv.Visible = false;
            rfvText.Enabled = true;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        HttpPostedFile ccFile = Request.Files["ccFile"];
        if (ddlResponse.SelectedValue == "ClientAccepted" && (ccFile == null || ccFile.ContentLength <= 0)){
            Session["ErrorMessage"] = "Confrmation Copy is required!";
            return;
        }
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var _enquiryId = int.Parse(hdnEnquiryId.Value);
        enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.Id == _enquiryId).FirstOrDefault();
        if (enquiry == null || enquiry.Status != "QuotationReleased"){
            Session["ErrorMessage"] = enquiry == null ? "You are not authorized to access that enquiry!" : "Enquiry state cannot be changed now!";
            Response.Redirect("Index.aspx");
            return;
        }
        enquiry.Status = ddlResponse.SelectedValue;
        var _currentUserName = User.Identity.Name;
        var notificationText = "";
        if (ddlResponse.SelectedValue == "ClientAccepted")
        {
            Hashtable hash = FileHelper.UpdateCommentFile(ccFile, _enquiryId, "confirmation_copy_file_");
            enquiry.ConfirmationCopyFileName = hash["fileName"].ToString();
            enquiry.ConfirmationCopyFilePath = hash["filePath"].ToString();
            notificationText = "Enquiry Accepted By Client. Updated By " + _currentUserName + "!";
        }
        if(!string.IsNullOrEmpty(txtText.Text)) {
            if (ddlResponse.SelectedValue == "ClientDeclined")
            {
                enquiry.ClientDeclinedReason = txtText.Text.Trim();
                notificationText = "Enquiry Declined By Client. Updated By " + _currentUserName + "!";
            }
            else if (ddlResponse.SelectedValue == "ClientReconsiderQuotation") {
                notificationText = "Client Enquiry For Reconsider. Updated By "+_currentUserName+"!";
            }
            var commentText = StringHelper.ToSentenceCase(ddlResponse.SelectedValue) + " - " + txtText.Text.Trim();
            var comment = new Comment { Text = commentText, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, EnquiryId = _enquiryId };
            _quotationTrackingSystemDBEntities.AddToComments(comment);
        }
        var _underWriterId = enquiry.UnderWriterId;
        EnquiryHelper.SendNotifications(_quotationTrackingSystemDBEntities, enquiry, _currentUserName, notificationText, false);
        var newEvent = new Event { State = ddlResponse.SelectedValue, CreatedBy = _currentUserName, CreatedAt = DateTime.Now, EnquiryId = _enquiryId };
        _quotationTrackingSystemDBEntities.AddToEvents(newEvent);
        _quotationTrackingSystemDBEntities.SaveChanges();
        Response.Redirect("Details.aspx?id=" + hdnEnquiryId.Value);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Details.aspx?id=" + hdnEnquiryId.Value);
    }
}