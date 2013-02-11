<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Inbox.aspx.cs" Inherits="Emails_Inbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3 class="right">
    <a href="New.aspx">Compose</a> | 
    <a href="Sent.aspx">Sent Emails</a>
  </h3>
  <div class="clear"></div>
  <hr />
    <asp:GridView ID="gvInbox" runat="server" AllowPaging="True" CssClass="table table-bordered" 
        Width="100%" EmptyDataText="You don't have any emails in Inbox!" 
        onpageindexchanging="gvInbox_PageIndexChanging" 
        onrowdatabound="gvInbox_RowDataBound" PageSize="30">
    </asp:GridView>
</asp:Content>

