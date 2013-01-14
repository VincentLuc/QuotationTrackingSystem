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
<h3>Change Password For
    <asp:Label ID="lblUserName" runat="server" Text="Label"></asp:Label>
    </h3>
<hr />
    <table style="width:35%;">
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
                <asp:HiddenField ID="hdnFldUserId" runat="server" />
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

