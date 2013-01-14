<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="New.aspx.cs" Inherits="Users_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Users</a><span class="divider">></span></li>
    <li><a class="active">New</a></li>
  </ul>
</div>
<h3>New User</h3>
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
                Role</td>
            <td>
                <asp:DropDownList ID="ddlRole" runat="server">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    <asp:ListItem>Admin </asp:ListItem>
                    <asp:ListItem Value="Sales">Sales</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvRole" runat="server" 
                    ControlToValidate="ddlRole" ForeColor="#FF3300" SetFocusOnError="True" 
                    InitialValue="0">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Status</td>
            <td>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    <asp:ListItem Value="Active">Active</asp:ListItem>
                    <asp:ListItem Value="InActive">Inactive</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvStatus" runat="server" 
                    ControlToValidate="ddlStatus" ForeColor="#FF3300" SetFocusOnError="True" 
                    InitialValue="0">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                User Name</td>
            <td>
                <asp:TextBox ID="txtUserName" runat="server" MaxLength="45"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserName" runat="server" 
                    ControlToValidate="txtUserName" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Password</td>
            <td>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPassword" runat="server" 
                    ForeColor="#FF3300" ValidationExpression=".{6}.*" 
                    ControlToValidate="txtPassword" SetFocusOnError="True">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Confirm Password</td>
            <td>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                    ControlToValidate="txtConfirmPassword" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvConfirmPassword" runat="server" 
                    ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" 
                    ForeColor="#FF3300" SetFocusOnError="True">*</asp:CompareValidator>
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
                <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save" />
            </td>
            <td>
                <asp:Button ID="btnCacnel" runat="server" CausesValidation="False" 
                    onclick="btnCacnel_Click" Text="Cancel" />
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

