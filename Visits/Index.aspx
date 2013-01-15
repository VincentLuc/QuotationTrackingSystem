<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Visits_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3 class="right">
    <a href="New.aspx">New Visit</a>
  </h3>
  <div class="clear"></div>
  <hr />
    <asp:GridView ID="gvVisits" runat="server" AllowPaging="True" 
        onpageindexchanging="gvVisits_PageIndexChanging" 
        onrowdatabound="gvVisits_RowDataBound" Width="100%">
    </asp:GridView>
</asp:Content>

