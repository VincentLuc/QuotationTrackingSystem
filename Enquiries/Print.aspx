<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Print.aspx.cs" Inherits="Enquiries_Print" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3 class="left"><input id="btnPrint" runat="server" type="button" value="Print" onclick="window.print();"  class="btn btn-primary"/></h3>
<h3 class="right"><a href="Details.aspx?id=<%= enquiry.Id %>">Back</a></h3>
<div class="clear"></div>
<br />
<table class="table table-bordered">
  <tr class='read'>
       <td colspan="2"><span>Status:</span> <%= StringHelper.ToSentenceCase(enquiry.Status) %></td>
  </tr>
  <tr>
    <td>
      <span>Sales User:</span>&nbsp;<%= enquiry.tblUser.UserName %>
    </td>
    <td>
        <asp:HiddenField ID="hdnEnquiryId" runat="server" />
      <span>Underwriter:</span>&nbsp;<%= EnquiryHelper.EnquiryUnderWriterName(enquiry) %>
    </td>
  </tr>
  <tr>
    <td><span>Client Name:</span> <%= enquiry.ClientName %></td>
    <td><span>Contact Person Name:</span> <%= enquiry.ContactPersonName %></td>
  </tr>
  <tr>
    <td><span>Phone1:</span> <%= enquiry.Phone1 %></td>
    <td><span>Phone2:</span> <%= enquiry.Phone2 %></td>
  </tr>
  <tr>
    <td><span>Insurance Type:</span> <%= StringHelper.ToSentenceCase(enquiry.InsuranceType) %></td>
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
    <td><span>Expected Premium:</span> <%= enquiry.ExpectedPremium %></td>
    <td><span>Loss Ratio For <%= enquiry.CreatedAt.Year - 1 %>:</span> <%= StringHelper.ToFormattedString(enquiry.LossRatioOne.ToString()) %></td>
  </tr>
  <tr>
    <td><span>Loss Ratio For <%= enquiry.CreatedAt.Year - 2 %>:</span> <%= StringHelper.ToFormattedString(enquiry.LossRatioTwo.ToString()) %></td>
    <td><span>Loss Ratio For <%= enquiry.CreatedAt.Year - 3 %>:</span> <%= StringHelper.ToFormattedString(enquiry.LossRatioThree.ToString()) %></td>
  </tr>
</table>
</asp:Content>

