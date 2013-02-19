﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="Enquiries_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<style type="text/css">
    table span {
      font-weight: bold;
      font-size: 12px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Enquiries</a><span class="divider">></span></li>
    <li><a class="active">Details</a></li>
  </ul>
</div>
<hr />
<h3 class="left">Events</h3>
<table class="table table-bordered">
  <thead>
    <tr>
      <th>Created At</th>
      <th>Created By</th>
      <th>Action</th>
    </tr>
  </thead>
  <tbody>
    <% foreach(var enquiryEvent in enquiry.Events.OrderBy(x => x.CreatedAt)) {%>
      <tr>
        <td><%= DateTimeHelper.To24Hours(enquiryEvent.CreatedAt) %></td>
        <td><%= enquiryEvent.CreatedBy %></td>
        <td><%= StringHelper.ToSentenceCase(enquiryEvent.State)%></td>
      </tr>
    <% } %>
  </tbody>
</table>
<div class="clear"></div>
<h3 class="left">Enquiry Details</h3>
<% if (enquiry.Status == "MissingInformation")
   { %>
<h3 class="right"><a href="RespondToMissingInformation.aspx?id=<%= enquiry.Id %>">Respond To Missing Information</a></h3>
<%} %>
<% if (enquiry.Status == "QuotationReleased")
   { %>
<h3 class="right"><a href="ClientResponse.aspx?id=<%= enquiry.Id %>">Client Response</a></h3>
<%} %>
<div class="clear"></div>
<table class="table table-bordered">
  <tr class='read'>
       <td colspan="2"><span>Status:</span> <%= StringHelper.ToSentenceCase(enquiry.Status) %></td>
  </tr>
  <% if (enquiry.Status == "ClientAccepted"){ %>
      <tr>
        <td>
          <span>Confirmation Copy: </span><%= enquiry.ConfirmationCopyFileName %>
        </td>
        <td>
          <asp:Button ID="btnCC" runat="server" Text="Download" onclick="btnCC_Click" CausesValidation="False" />
        </td>
      </tr>
   <%} %>
   <% if (enquiry.Status == "ClientDeclined")
      { %>
      <tr>
        <td colspan="2"><span>Reason: </span> <%= enquiry.ClientDeclinedReason %></td>
      </tr>
   <%} %>
  <tr>
    <td><span>Client Name:</span> <%= enquiry.ClientName %></td>
    <td><span>Contact Person Name:</span> <%= enquiry.ContactPersonName %></td>
  </tr>
  <tr>
    <td><span>Phone1:</span> <%= enquiry.Phone1 %></td>
    <td><span>Phone2:</span> <%= enquiry.Phone2 %></td>
  </tr>
  <tr>
    <td><span>Insurance Type:</span> <%= enquiry.InsuranceType %></td>
    <td><span>Intended Policy Start At:</span> <%= DateTimeHelper.ConvertToString(enquiry.IntendedPolicyStartAt.ToString()) %></td>
  </tr>
  <tr>
    <td><span>Insurance For:</span> <%= enquiry.InsuranceFor %></td>
    <td>
      <% if (enquiry.InsuranceFor == "Individual")
      {%>
        <span>National Id / Iqama Number:</span> <%= enquiry.NationalIdOrIqamaNumber %>
        <%} %>
        <% else {%>
        <span>CR Number:</span> <%= enquiry.CRNumber %>
      <%} %>
    </td>
  </tr>
  <tr>
    <td><span>Address:</span> <%= enquiry.Address %></td>
    <td><span>Remarks:</span> <%= enquiry.Remarks %></td>
  </tr>
  <tr>
    <td><span>Created At:</span> <%= DateTimeHelper.ConvertToString(enquiry.CreatedAt.ToString()) %></td>
    <td><span>Updated At:</span> <%= DateTimeHelper.ConvertToString(enquiry.UpdatedAt.ToString()) %></td>
  </tr>
  <tr>
    <td><span>Copy of CR:</span> <%= enquiry.CRCopyName %></td>
    <td><asp:Button ID="btnDownload" runat="server" Text="Download" 
            onclick="btnDownload_Click" CausesValidation="False"/></td>
  </tr>
  <% if(!string.IsNullOrEmpty(enquiry.PreviousLossRatioReportPath)) {%>
    <tr>
      <td><span>Previous Loss Ratio Report:</span> <%= enquiry.PreviousLossRatioReportName%></td>
      <td><asp:Button ID="btnLossRatio" runat="server" Text="Download" 
              onclick="btnLossRatio_Click" CausesValidation="False"/></td>
    </tr>
  <% } %>
  <% if(!string.IsNullOrEmpty(enquiry.AdditionalDocumentName)) {%>
    <tr>
      <td><span>Additional Documents:</span> <%= enquiry.AdditionalDocumentName%></td>
      <td><asp:Button ID="btnAdditionalDocument" runat="server" Text="Download" 
              onclick="btnAdditionalDocument_Click" CausesValidation="False"/></td>
    </tr>
  <% } %>
  <% if(enquiry.Status == "QuotationReleased") {%>
    <tr>
      <td><span>Quotation Document:</span> <%= enquiry.QuotationFileName%></td>
      <td><asp:Button ID="btnQuotationDocument" runat="server" Text="Download" onclick="btnQuotationDocument_Click" CausesValidation="False"/></td>
    </tr>
  <% } %>
  <tr>
    <td colspan="2">
        <asp:HiddenField ID="hdnEnquiryId" runat="server" />
      Underwriter: <%= UnderWriterName %>
    </td>
  </tr>
</table>
<h3 class="left">Comments</h3>
<table class="table table-bordered">
  <thead>
    <tr>
      <th>Created At</th>
      <th>Created By</th>
      <th>File</th>
      <th>Comment</th>
    </tr>
  </thead>
  <tbody>
    <% foreach(var enquiryComment in enquiry.Comments.OrderBy(x => x.CreatedAt)) {%>
      <tr>
        <td><%= DateTimeHelper.To24Hours(enquiryComment.CreatedAt) %></td>
        <td><%= enquiryComment.CreatedBy %></td>
        <td>
        <% if(string.IsNullOrEmpty(enquiryComment.FilePath)) {%>
            No File attached !
          <%}else{ %>
            <a href="/QuotationTrackingSystem/Comments/Download.aspx?id=<%= enquiryComment.Id %>" class="btn" target="_blank" style="color:#000;">Download</a>
          <%} %>
        </td>
        <td><%= enquiryComment.Text %></td>
      </tr>
    <% } %>
  </tbody>
</table>
<div class="clear"></div>
<fieldset>
  <legend>Add Comment</legend>
  <p>
    <label>File</label>
    <input type="file" id="commentFile" name="commentFile" />
  </p>
  <p>
    <label>Text</label>
    <asp:TextBox ID="txtText" runat="server" MaxLength="495" Height="166px" 
          TextMode="MultiLine" Width="305px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvText" runat="server" 
                    ControlToValidate="txtText" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
    <p>
        <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save" />
  </p>
</fieldset>
</asp:Content>

