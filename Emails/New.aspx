<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="New.aspx.cs" Inherits="Emails_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Inbox.aspx">Mails</a><span class="divider">></span></li>
    <li><a class="active">New</a></li>
  </ul>
</div>
<fieldset>
  <legend>New Email</legend>
  <p>
    <label>To</label>
      <asp:DropDownList ID="ddlSentTo" runat="server">
      </asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfvSentTo" runat="server" 
                    ControlToValidate="ddlSentTo" ForeColor="#FF3300" 
                    SetFocusOnError="True" InitialValue="0">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Subject</label>
    <asp:TextBox ID="txtSubject" runat="server" MaxLength="300"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvSubject" runat="server" 
                    ControlToValidate="txtSubject" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Body</label>
    <asp:TextBox ID="txtBody" runat="server" Height="161px" TextMode="MultiLine" 
          Width="307px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvBody" runat="server" 
                    ControlToValidate="txtBody" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
      <asp:Button ID="btnSend" runat="server" Text="Send" CssClass="btn" 
          onclick="btnSend_Click" />
      &nbsp;
      <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
          onclick="btnCancel_Click" CausesValidation="False" />
  </p>
</fieldset>
</asp:Content>

