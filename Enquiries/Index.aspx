﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Enquiries_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <h3 class="right">
    <a href="New.aspx">New Enquiry</a>
  </h3>
  <div class="clear"></div>
  <hr />
  <div class="navbar">
  <div class="navbar-inner">
    <a class="brand" href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=Created">Enquiries</a>
    <ul class="nav">
      <li class="<%= (Request.QueryString["scope"] == null || Request.QueryString["scope"] == "Created") ? "active" : "" %>"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=Created">New</a></li>
      <li class="<%= (Request.QueryString["scope"] == "Declined") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=Declined" style="width:155px;">Underwriter Declined</a></li>
      <li class="<%= (Request.QueryString["scope"] == "AdditionalInformation") ? "active" : "" %>" style="width:165px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=AdditionalInformation" style="width:155px;">Additional informariton</a></li>
      <li class="<%= (Request.QueryString["scope"] == "MissingInformation") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=MissingInformation" style="width:155px;">Missing informariton</a></li>
      <li class="<%= (Request.QueryString["scope"] == "QuotationReleased") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=QuotationReleased" style="width:155px;">Realeased Quotation</a></li>
      <li class="<%= (Request.QueryString["scope"] == "ClientDeclined") ? "active" : "" %>" style="width:121px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=ClientDeclined" style="width:155px;">Client Declined</a></li>
      <li class="<%= (Request.QueryString["scope"] == "ClientAccepted") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=ClientAccepted" style="width:155px;">Client Accepted</a></li>
    </ul>
   </div>
</div>
    <asp:HiddenField ID="hdnScope" runat="server" />
    <asp:GridView ID="gvEnquiries" runat="server" AllowPaging="True" 
        EmptyDataText="There are no enquiries !" 
        onpageindexchanging="gvEnquiries_PageIndexChanging" 
        onrowdatabound="gvEnquiries_RowDataBound" Width="100%" 
        CssClass="table table-bordered">
    </asp:GridView>

</asp:Content>

