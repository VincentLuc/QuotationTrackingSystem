<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="Enquiries_Details" %>

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
<table class="table table-bordered">
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
    <td colspan="2"><span>Status:</span> <%= enquiry.Status %></td>
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
  <tr>
    <td colspan="2">
        <asp:HiddenField ID="hdnEnquiryId" runat="server" />
      Underwriter: <%= UnderWriterName %>
    </td>
  </tr>
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
        <td><%= enquiryEvent.State %></td>
        <td><%= DateTimeHelper.To24Hours(enquiryEvent.CreatedAt) %></td>
      </tr>
    <% } %>
  </tbody>
</table>
<div class="clear"></div>
</asp:Content>

