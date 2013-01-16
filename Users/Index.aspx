<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Users_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3 class="right">
    <a href="New.aspx">New User</a>
  </h3>
  <div class="clear"></div>
  <hr />
    <asp:GridView ID="gvUsers" runat="server" AllowPaging="True" 
        onpageindexchanging="gvUsers_PageIndexChanging" 
        onrowdatabound="gvUsers_RowDataBound" PageSize="20" Width="100%" 
        CssClass="table table-bordered">
    </asp:GridView>
</asp:Content>

