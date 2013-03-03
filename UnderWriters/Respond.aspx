<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Respond.aspx.cs" Inherits="UnderWriters_Respond" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Enquiries.aspx">Enquiries</a><span class="divider">></span></li>
    <li><a href="EnquiryDetails.aspx?id=<%= hdnEnquiryId.Value %>"><%= hdnEnquiryId.Value %></a><span class="divider">></span></li>
    <li><a class="active">Respond</a></li>
  </ul>
</div>
<fieldset>
  <legend>Respond To Enquiry</legend>
  <p>
    <label>Status<asp:DropDownList ID="ddlStatus" runat="server" CssClass="ddlstatus" 
          onselectedindexchanged="ddlStatus_SelectedIndexChanged" 
          AutoPostBack="True">
          <asp:ListItem Value="QuotationReleased">Release Quotation</asp:ListItem>
          <asp:ListItem Value="UnderwriterDeclined">Decline</asp:ListItem>
          <asp:ListItem Value="AdditionalInformation">Additional Information</asp:ListItem>
          <asp:ListItem Value="MissingInformation">Missing Information</asp:ListItem>
      </asp:DropDownList>
      </label>
  &nbsp;</p>
  <p id="quotationDiv" runat="server">
    <label>Quotation File</label>
    <input type="file" id="quotationFile" name="quotationFile" />
      <asp:HiddenField ID="hdnEnquiryId" runat="server" />
  </p>
  <p id="declinedDiv" runat="server">
    <label>Reason</label>
    <asp:TextBox ID="txtText" runat="server" Height="166px" 
          TextMode="MultiLine" Width="305px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvText" runat="server" 
                    ControlToValidate="txtText" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
    <p>
        <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save" />
        &nbsp;
      <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
          onclick="btnCancel_Click" CausesValidation="False" />
  </p>
</fieldset>
</asp:Content>

