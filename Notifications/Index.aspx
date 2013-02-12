<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Notifications_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:GridView ID="gvNotifications" runat="server" AllowPaging="True" 
        CssClass="table table-bordered" 
    EmptyDataText="You don't have any notifications!" PageSize="30" 
        Width="100%" onpageindexchanging="gvNotifications_PageIndexChanging" 
    onrowdatabound="gvNotifications_RowDataBound">
    </asp:GridView>
</asp:Content>

