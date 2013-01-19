<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="SalesSupervisor_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>Sales Supervisor sales users !</h3>
<hr />
<div class="clear"></div>
<table class="table table-bordered">
<tr>
<th>User Name</th>
<th>Visisted Date</th>
<th>Total Count</th>
</tr>
<% foreach (var x in _visitDetailsList)
   { %>
   <tr>
   <td><%= x.UserName %></td>
   <td><%= x.VisitedAt %></td>
   <td><%= x.Count %></td>
   </tr>
<% } %>
</table>
</asp:Content>

