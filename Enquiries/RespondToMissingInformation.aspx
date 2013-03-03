<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="RespondToMissingInformation.aspx.cs" Inherits="Enquiries_RerspondToMissingInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Enquiries</a><span class="divider">></span></li>
    <li><a href="Details.aspx?id=<%= hdnEnquiryId.Value %>"><%= hdnEnquiryId.Value %></a><span class="divider">></span></li>
    <li><a class="active">Respond To Missing Information</a></li>
  </ul>
</div>
<asp:HiddenField ID="hdnEnquiryId" runat="server" />
<fieldset>
  <legend>Respond To Additional / Missing Information</legend>
  <p>
    <label>File</label>
    <input type="file" id="commentFile" name="commentFile" />
  </p>
  <p>
    <label>Text</label>
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

