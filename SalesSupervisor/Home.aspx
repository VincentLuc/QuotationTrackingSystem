<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="SalesSupervisor_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>Home Page For Sales Supervisor !</h3>
<hr />
<h3 class="left">My Sales Users</h3>
<div class="clear"></div>
    <asp:GridView ID="gvSalesUsers" runat="server" AllowPaging="True" 
        onpageindexchanging="gvSalesUsers_PageIndexChanging" 
        onrowdatabound="gvSalesUsers_RowDataBound" Width="100%">
    </asp:GridView>
</asp:Content>

