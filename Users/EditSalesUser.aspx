<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EditSalesUser.aspx.cs" Inherits="Users_EditSalesUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Users</a><span class="divider">></span></li>
    <li><a href="Details.aspx?id=<%= SupervisorUser.Id%>"><%= SupervisorUser.UserName %></a><span class="divider">></span></li>
    <li><a href="Details.aspx?id=<%= SupervisorUser.Id%>"><%= SalesUser.UserName %></a><span class="divider">></span></li>
    <li><a class="active">Edit Sales User</a></li>
  </ul>
</div>
<h3>Edit Sales User</h3>
<hr />
    <table style="width:35%;">
        <tr>
            <td align="left">
                First Name<asp:HiddenField 
                    ID="hdnSalesSupervisorId" runat="server" />
            </td>
            <td>
                <asp:TextBox ID="txtFirstName" runat="server" MaxLength="45"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                    ControlToValidate="txtFirstName" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Middle Name<asp:HiddenField ID="hdnFldSalesUser" runat="server" />
            </td>
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

