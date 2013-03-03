<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="Users_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Users</a><span class="divider">></span></li>
    <li>Edit</li>
  </ul>
</div>
<fieldset>
  <legend>Edit User</legend>
  <p>
    <label>First Name</label>
    <asp:TextBox ID="txtFirstName" runat="server" MaxLength="300"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                    ControlToValidate="txtFirstName" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Middle Name</label>
    <asp:TextBox ID="txtMiddleName" runat="server" MaxLength="300"></asp:TextBox>
    <asp:HiddenField ID="hdnFldUserId" runat="server" />
  </p>
  <p>
    <label>Last Name</label>
    <asp:TextBox ID="txtLastName" runat="server" MaxLength="300"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                    ControlToValidate="txtLastName" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Role</label>
    <asp:DropDownList ID="ddlRole" runat="server">
      <asp:ListItem Value="0">Select</asp:ListItem>
      <asp:ListItem Value="Admin">Admin </asp:ListItem>
      <asp:ListItem Value="Sales">Sales</asp:ListItem>
      <asp:ListItem Value="UnderWriter">Under Writer</asp:ListItem>
    </asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfvRole" runat="server" 
                    ControlToValidate="ddlRole" ForeColor="#FF3300" SetFocusOnError="True" 
                    InitialValue="0">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Status</label>
    <asp:DropDownList ID="ddlStatus" runat="server">
      <asp:ListItem Value="0">Select</asp:ListItem>
      <asp:ListItem Value="Active">Active</asp:ListItem>
      <asp:ListItem Value="InActive">Inactive</asp:ListItem>
    </asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" 
                    ControlToValidate="ddlStatus" ForeColor="#FF3300" SetFocusOnError="True" 
                    InitialValue="0">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>User Name</label>
    <asp:TextBox ID="txtUserName" runat="server" MaxLength="300"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvUserName" runat="server" 
                    ControlToValidate="txtUserName" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p></p>
  <p>
    <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save"  CssClass="btn btn-save"/>
    <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                    onclick="btnCancel_Click" Text="Cancel"  CssClass="btn"/>
  </p>
  <//fieldset>
</asp:Content>

