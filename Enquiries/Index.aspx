<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Enquiries_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <h3 class="right">
    <a href="New.aspx">New Enquiry</a>
  </h3>
  <div class="clear"></div>
  <hr />

    <asp:GridView ID="gvEnquiries" runat="server" AllowPaging="True" 
        EmptyDataText="There are no enquiries !" 
        onpageindexchanging="gvEnquiries_PageIndexChanging" 
        onrowdatabound="gvEnquiries_RowDataBound" Width="100%" 
        CssClass="table table-bordered">
    </asp:GridView>

</asp:Content>

