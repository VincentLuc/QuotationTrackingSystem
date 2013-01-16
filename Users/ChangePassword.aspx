<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Users_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Users</a><span class="divider">></span></li>
    <li><a class="active">Change Password</a></li>
  </ul>
</div>
<fieldset>
  <legend>Change Password For <asp:Label ID="lblUserName" runat="server" Text="Label"></asp:Label></legend>
  <p>
    <label>Password</label>
    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" MaxLength="45"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="revPassword" runat="server" 
                    ForeColor="#FF3300" ValidationExpression=".{6}.*" 
                    ControlToValidate="txtPassword" SetFocusOnError="True">*</asp:RegularExpressionValidator>
    <asp:HiddenField ID="hdnFldUserId" runat="server" />
  </p>
  <p>
    <label>Confirm Password</label>
    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" 
                    MaxLength="45"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                    ControlToValidate="txtConfirmPassword" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
    <asp:CompareValidator ID="cvConfirmPassword" runat="server" 
                    ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" 
                    ForeColor="#FF3300" SetFocusOnError="True">*</asp:CompareValidator>
  </p>
  <p></p>
  <p>
    <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save"  CssClass="btn btn-save"/>
    <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                    onclick="btnCancel_Click" Text="Cancel"  CssClass="btn"/>
  </p>
</fieldset>
</asp:Content>

