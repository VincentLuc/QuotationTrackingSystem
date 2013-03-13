<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EnquiryDetails.aspx.cs" Inherits="UnderWriters_EnquiryDetails" %>

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
    <li><a href="Enquiries.aspx">Enquiries</a><span class="divider">></span></li>
    <li><a class="active">Details</a></li>
  </ul>
</div>
<hr />
<h3 class="left">Events</h3>
<h3 class="right"><a href="Print.aspx?id=<%= enquiry.Id %>">Take Print</a></h3>
<div class="clear"></div>
<table class="table table-bordered">
  <thead>
    <tr>
      <th>Created At</th>
      <th>Created By</th>
      <th>Action</th>
    </tr>
  </thead>
  <tbody>
    <% foreach(var enquiryEvent in enquiry.Events) {%>
      <tr>
        <td><%= DateTimeHelper.To24Hours(enquiryEvent.CreatedAt) %></td>
        <td><%= enquiryEvent.CreatedBy %></td>
        <td><%= StringHelper.ToSentenceCase(enquiryEvent.State) %></td>
      </tr>
    <% } %>
  </tbody>
</table>
<div class="clear"></div>
<h3 class="left">Enquiry Details</h3>
<% if (hasDirectAccess)
   {%>
<% if (enquiry.Status == "New" || enquiry.Status == "UnderWriterViewed" || enquiry.Status == "InformationUpdate")
   {%>
<h3 class="right"><a href="Respond.aspx?id=<%= hdnEnquiryId.Value %>">Respond</a></h3>
<%} %>
<%} %>
<div class="clear"></div>
<table class="table table-bordered">
  <tr class='read'>
    <td colspan="2"><span>Status:</span> <%= StringHelper.ToSentenceCase(enquiry.Status) %></td>
  </tr>
   <tr>
    <td>
      <span>Sales User:</span>&nbsp;<%= enquiry.tblUser.UserName %>
    </td>
    <td>
        <asp:HiddenField ID="HiddenField1" runat="server" />
      <span>Underwriter:</span>&nbsp;<%= EnquiryHelper.EnquiryUnderWriterName(enquiry) %>
    </td>
  </tr>
   <% if (enquiry.Status == "ClientDeclined")
      { %>
      <tr>
        <td colspan="2"><span>Client Declined Reason: </span> <%= enquiry.ClientDeclinedReason %></td>
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
    <td><span>Expected Premium:</span> <%= enquiry.ExpectedPremium %></td>
    <td><span>Loss Ratio For <%= enquiry.CreatedAt.Year - 1 %>:</span> <%= StringHelper.ToFormattedString(enquiry.LossRatioOne.ToString()) %></td>
  </tr>
  <tr>
    <td><span>Loss Ratio For <%= enquiry.CreatedAt.Year - 2 %>:</span> <%= StringHelper.ToFormattedString(enquiry.LossRatioTwo.ToString()) %></td>
    <td><span>Loss Ratio For <%= enquiry.CreatedAt.Year - 3 %>:</span> <%= StringHelper.ToFormattedString(enquiry.LossRatioThree.ToString()) %></td>
  </tr>
  <tr>
    <td><span>Copy of CR:</span> <%= enquiry.CRCopyName %></td>
    <td><asp:Button ID="btnDownload" runat="server" Text="Download" onclick="btnDownload_Click" CausesValidation="False"/></td>
  </tr>
  <% if(!string.IsNullOrEmpty(enquiry.PreviousLossRatioReportPath)) {%>
    <tr>
      <td><span>Previous Loss Ratio Report:</span> <%= enquiry.PreviousLossRatioReportName%></td>
      <td><asp:Button ID="btnLossRatio" runat="server" Text="Download" onclick="btnLossRatio_Click" CausesValidation="False"/></td>
    </tr>
  <% } %>
  <% if(!string.IsNullOrEmpty(enquiry.AdditionalDocumentName)) {%>
    <tr>
      <td><span>Proposal Form / Additional Documents:</span> <%= enquiry.AdditionalDocumentName%></td>
      <td><asp:Button ID="btnAdditionalDocument" runat="server" Text="Download" onclick="btnAdditionalDocument_Click" CausesValidation="False"/></td>
    </tr>
  <% } %>
  <% if(!string.IsNullOrEmpty(enquiry.QuotationFileName)) {%>
    <tr>
      <td><span>Quotation Document:</span> <%= enquiry.QuotationFileName%></td>
      <td><asp:Button ID="btnQuotationDocument" runat="server" Text="Download" onclick="btnQuotationDocument_Click" CausesValidation="False"/></td>
    </tr>
  <% } %>
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
        <asp:HiddenField ID="hdnEnquiryId" runat="server" />
</table>
<h3 class="left">Sales Users copy</h3>
<div class="clear"></div>
<table class="table table-bordered">
<tbody>
<tr>
<% if (copySalesUsers.Count == 0)
   { %>
   <td>No copy to sales users</td>
<%}
   else
   {%>
<% foreach (var x in copySalesUsers)
   {%>
   <td><%= x.UserName %></td>
<%} %>
<%} %>
</tr>
</tbody>
</table>
<h3 class="left">Underwriter Users copy</h3>
<div class="clear"></div>
<table class="table table-bordered">
<tbody>
<tr>
<% if (copyUnderwriterUsers.Count == 0)
   { %>
   <td>No copy to underwriters</td>
<%}
   else
   {%>
<% foreach (var x in copyUnderwriterUsers)
   {%>
   <td><%= x.UserName%></td>
<%} %>
<%} %>
</tr>
</tbody>
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
    <% foreach(var enquiryComment in enquiry.Comments.OrderByDescending(x => x.CreatedAt)) {%>
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
        <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save" CssClass="btn btn-primary" />
  </p>
</fieldset>
</asp:Content>

