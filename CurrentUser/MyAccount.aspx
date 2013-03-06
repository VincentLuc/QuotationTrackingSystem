<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyAccount.aspx.cs" Inherits="MyAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="breadcrumb">
  <ul>
    <li><a href="<%= CurrentUser.GetRedirectPath(CurrentUser.Role())%>">Home</a><span class="divider">></span></li>
    <li><a class="active">My Account</a></li>
  </ul>
</div>
<fieldset>
<legend>My Account</legend>
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
    </p>
    <p>
      <label>Last Name</label>
      <asp:TextBox ID="txtLastName" runat="server" MaxLength="300"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                    ControlToValidate="txtLastName" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
    </p>
    <p></p>
    <p>
      <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save"  CssClass="btn btn-save btn-primary"/>
      <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                    onclick="btnCancel_Click" Text="Cancel"  CssClass="btn"/>
    </p>
    </fieldset>
</asp:Content>

