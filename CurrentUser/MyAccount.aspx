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
<h3>My Account</h3>
<hr />
    <table style="width:35%;">
        <tr>
            <td align="left">
                First Name</td>
            <td>
                <asp:TextBox ID="txtFirstName" runat="server" MaxLength="45"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                    ControlToValidate="txtFirstName" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Middle Name</td>
            <td>
                <asp:TextBox ID="txtMiddleName" runat="server" MaxLength="45"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="left">
                Last Name</td>
            <td>
                <asp:TextBox ID="txtLastName" runat="server" MaxLength="45"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                    ControlToValidate="txtLastName" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center">
                <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save"  CssClass="btn"/>
            </td>
            <td>
                <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                    onclick="btnCancel_Click" Text="Cancel"  CssClass="btn"/>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

