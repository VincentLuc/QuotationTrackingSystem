<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EnquiryDetails.aspx.cs" Inherits="UnderWriters_EnquiryDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Enquiries.aspx">Enquiries</a><span class="divider">></span></li>
    <li><a class="active">Details</a></li>
  </ul>
</div>
<hr />
<table class="table table-bordered">
  <tr>
      <asp:HiddenField ID="hdnEnquiryId" runat="server" />
    <td><span>Client Name:</span> <%= enquiry.Address %></td>
    <td><span>Contact Person Name:</span> <%= enquiry.Remarks %></td>
  </tr>
  <tr>
    <td><span>Phone1:</span> <%= DateTimeHelper.ConvertToString(enquiry.CreatedAt.ToString()) %></td>
    <td><span>Phone2:</span> <%= DateTimeHelper.ConvertToString(enquiry.UpdatedAt.ToString()) %></td>
  </tr>
  <tr>
    <td><span>Insurance Type:</span> <%= enquiry.CRCopyName %></td>
    <td><span>Intended Policy Start At:</span> <% if(!string.IsNullOrEmpty(enquiry.PreviousLossRatioReportPath)) {%></td>
  </tr>
  <tr>
    <td><span>Insurance For:</span> <%= enquiry.PreviousLossRatioReportName%></td>
    <td>
        <% } %>
        <span>National Id / Iqama Number:</span> <% if(!string.IsNullOrEmpty(enquiry.AdditionalDocumentName)) {%>        <%= enquiry.AdditionalDocumentName%>        <% } %>
        <span>CR Number:</span> <% foreach(var enquiryEvent in enquiry.Events) {%>      <%= enquiryEvent.CreatedBy %>
    </td>
  </tr>
  <tr>
    <td colspan="2"><span>Status:</span> <%= enquiryEvent.State %></td>
  </tr>
  <tr>
    <td><span>Address:</span> <%= DateTimeHelper.To24Hours(enquiryEvent.CreatedAt) %></td>
    <td><span>Remarks:</span> <% } %></td>
  </tr>
  <tr>
    <td><span>Created At:</span> <%= DateTimeHelper.ConvertToString(enquiry.CreatedAt.ToString()) %></td>
    <td><span>Updated At:</span> <%= DateTimeHelper.ConvertToString(enquiry.UpdatedAt.ToString()) %></td>
  </tr>
  <tr>
    <td><span>Copy of CR:</span> <%= enquiry.CRCopyName %></td>
    <td><asp:Button ID="btnDownload" runat="server" Text="Download" onclick="btnDownload_Click"/></td>
  </tr>
  <% if(!string.IsNullOrEmpty(enquiry.PreviousLossRatioReportPath)) {%>
    <tr>
      <td><span>Previous Loss Ratio Report:</span> <%= enquiry.PreviousLossRatioReportName%></td>
      <td><asp:Button ID="btnLossRatio" runat="server" Text="Download" onclick="btnLossRatio_Click"/></td>
    </tr>
  <% } %>
  <% if(!string.IsNullOrEmpty(enquiry.AdditionalDocumentName)) {%>
    <tr>
      <td><span>Additional Documents:</span> <%= enquiry.AdditionalDocumentName%></td>
      <td><asp:Button ID="btnAdditionalDocument" runat="server" Text="Download" onclick="btnAdditionalDocument_Click"/></td>
    </tr>
  <% } %>
</table>
<h3 class="left">Events</h3>
<table class="table table-bordered">
  <thead>
    <tr>
      <th>Created By</th>
      <th>State</th>
      <th>Created At</th>
    </tr>
  </thead>
  <tbody>
    <% foreach(var enquiryEvent in enquiry.Events) {%>
      <tr>
        <td><%= enquiryEvent.CreatedBy %></td>
        <td><%= StringHelper.ToSentenceCase(enquiryEvent.State) %></td>
        <td><%= DateTimeHelper.To24Hours(enquiryEvent.CreatedAt) %></td>
      </tr>
    <% } %>
  </tbody>
</table>
<div class="clear"></div>
</asp:Content>

