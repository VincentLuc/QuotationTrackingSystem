<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ClientResponse.aspx.cs" Inherits="Enquiries_ClientResponse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Enquiries</a><span class="divider">></span></li>
    <li><a href="Details.aspx?id=<%= hdnEnquiryId.Value %>"><%= hdnEnquiryId.Value %></a><span class="divider">></span></li>
    <li><a class="active">Client Response</a></li>
  </ul>
</div>
<fieldset>
  <asp:HiddenField ID="hdnEnquiryId" runat="server" />
  <legend>Response From Client</legend>
  <p>
    <label>Response</label>
      <asp:DropDownList ID="ddlResponse" runat="server" AutoPostBack="True" 
          onselectedindexchanged="ddlResponse_SelectedIndexChanged">
          <asp:ListItem Value="ClientAccepted">Accepted</asp:ListItem>
          <asp:ListItem Value="ClientDeclined">Declined</asp:ListItem>
      </asp:DropDownList>
  </p>
   <p id="confirmationDiv" runat="server">
    <label>Confirmation Copy</label>
    <input type="file" id="ccFile" name="ccFile" />
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

