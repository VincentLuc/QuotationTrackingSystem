<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Sent.aspx.cs" Inherits="Emails_Sent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Inbox.aspx">Emails</a><span class="divider">></span></li>
    <li><a class="active">Sent</a></li>
  </ul>
</div>
    <asp:GridView ID="gvSentEmails" runat="server" AllowPaging="True" 
        CssClass="table table-bordered" 
    EmptyDataText="There are no emails sent !" 
        Width="100%" onpageindexchanging="gvSentEmails_PageIndexChanging" 
    onrowdatabound="gvSentEmails_RowDataBound" PageSize="30">
    </asp:GridView>
</asp:Content>

