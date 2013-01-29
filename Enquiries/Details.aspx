<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="Enquiries_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Enquiries</a><span class="divider">></span></li>
    <li><a class="active">Details</a></li>
  </ul>
</div>
<hr />
<a href="Edit.aspx?id=<%= enquiry.Id %>" class="right btn btn-primary">Edit</a>
<div class="clear"></div>
<br />
<table class="table table-bordered">
  <tr>
    <td>Client Name: <%= enquiry.ClientName %></td>
    <td>Contact Person Name: <%= enquiry.ContactPersonName %></td>
  </tr>
  <tr>
    <td>Phone: <%= enquiry.Phone %></td>
    <td>Insurance Type: <%= enquiry.InsuranceType %></td>
  </tr>
  <tr>
    <td>Policy Start At: <%= DateTimeHelper.ConvertToString(enquiry.PolicyStartAt.ToString()) %></td>
    <td>Status: <%= enquiry.Status %></td>
  </tr>
  <tr>
    <td>Address: <%= enquiry.Address %></td>
    <td>Remarks: <%= enquiry.Remarks %></td>
  </tr>
  <tr>
    <td>Created At: <%= DateTimeHelper.ConvertToString(enquiry.CreatedAt.ToString()) %></td>
    <td>Updated At: <%= DateTimeHelper.ConvertToString(enquiry.UpdatedAt.ToString()) %></td>
  </tr>
  <tr>
    <td>Copy of CR: <%= enquiry.CRCopyName %></td>
    <td><asp:Button ID="btnDownload" runat="server" Text="Download" onclick="btnDownload_Click"/></td>
  </tr>
  <% if(!string.IsNullOrEmpty(enquiry.LossRatioReportPath)) {%>
    <tr>
      <td>Loss Ratio Report: <%= enquiry.LossRatioReportName %></td>
      <td><asp:Button ID="btnLossRatio" runat="server" Text="Download" onclick="btnLossRatio_Click"/></td>
      <td></td>
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

