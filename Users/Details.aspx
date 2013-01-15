<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="Users_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Users</a><span class="divider">></span></li>
    <li><a class="active">Details</a></li>
  </ul>
</div>
<h3>User Details</h3>
<hr />
<% if (CurrentUser.IsSalesSupervisor(_user.Id.ToString()))
   {%>
<h3 class="right">
    <a href="NewSalesUser.aspx?Supervisorid=<%= _user.Id%>">New Sales User</a>
</h3>
<div class="clear"></div>
<%} %>
    <table style="width:100%;" class="borderTable">
        <tr>
            <td align="left" style="width:25%;">First Name<asp:HiddenField ID="hdnFldUserId" runat="server" /></td>
            <td><%= _user.FirstName %></td>
        </tr>
        <tr>
            <td align="left">Middle Name</td>
            <td><%= _user.MiddleName %></td>
        </tr>
        <tr>
            <td align="left">Last Name</td>
            <td><%= _user.LastName %></td>
        </tr>
        <tr>
            <td align="left">User Name</td>
            <td><%= _user.UserName %></td>
        </tr>
        <tr>
            <td align="left">Role</td>
            <td><%= StringHelper.ToSentenceCase(_user.Role) %></td>
        </tr>
        <tr>
            <td align="left">Status</td>
            <td><%= _user.Status %></td>
        </tr>
        <tr>
            <td align="left">Created At</td>
            <td><%= DateTimeHelper.ConvertToString(_user.CreatedAt.ToString()) %></td>
        </tr>
        <tr>
            <td align="left">Updated At</td>
            <td><%= DateTimeHelper.ConvertToString(_user.UpdatedAt.ToString()) %></td>
        </tr>
        <tr>
            <td align="left">Last Sign in At</td>
            <td><%= DateTimeHelper.ConvertToString(_user.LastSignInAt.ToString()) %></td>
        </tr>
        <tr>
            <td align="left">Sign in Count</td>
            <td><%= _user.SignInCount %></td>
        </tr>
    </table>
    <hr />
    <% if (CurrentUser.IsSalesSupervisor(_user.Id.ToString()))
       {%>
    <h3 class="left">
      <a>Sales Users</a>
    </h3>
    <div class="clear"></div>
    <hr />
    <asp:GridView ID="gvSalesUser" runat="server" 
        onpageindexchanging="gvSalesUser_PageIndexChanging" 
        onrowdatabound="gvSalesUser_RowDataBound" Width="100%" AllowPaging="True">
    </asp:GridView>
    <%} %>
</asp:Content>

