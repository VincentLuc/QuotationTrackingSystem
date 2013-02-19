<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Enquiries.aspx.cs" Inherits="UnderWriters_Enquiries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:HiddenField ID="hdnScope" runat="server" />
<div class="navbar">
  <div class="navbar-inner">
    <a class="brand" href="/QuotationTrackingSystem/UnderWriters/Enquiries.aspx?scope=Created">Enquiries</a>
    <ul class="nav">
      <li class="<%= (Request.QueryString["scope"] == null || Request.QueryString["scope"] == "New") ? "active" : "" %>"><a href="/QuotationTrackingSystem/UnderWriters/Enquiries.aspx?scope=New">New</a></li>
      <li class="<%= (Request.QueryString["scope"] == "UnderwriterDeclined") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/UnderWriters/Enquiries.aspx?scope=UnderwriterDeclined" style="width:155px;">Underwriter Declined</a></li>
      <li class="<%= (Request.QueryString["scope"] == "AdditionalInformation") ? "active" : "" %>" style="width:165px;"><a href="/QuotationTrackingSystem/UnderWriters/Enquiries.aspx?scope=AdditionalInformation" style="width:155px;">Additional informariton</a></li>
      <li class="<%= (Request.QueryString["scope"] == "MissingInformation") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/UnderWriters/Enquiries.aspx?scope=MissingInformation" style="width:155px;">Missing informariton</a></li>
      <li class="<%= (Request.QueryString["scope"] == "QuotationReleased") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/UnderWriters/Enquiries.aspx?scope=QuotationReleased" style="width:155px;">Realeased Quotation</a></li>
      <li class="<%= (Request.QueryString["scope"] == "ClientDeclined") ? "active" : "" %>" style="width:121px;"><a href="/QuotationTrackingSystem/UnderWriters/Enquiries.aspx?scope=ClientDeclined" style="width:155px;">Client Declined</a></li>
      <li class="<%= (Request.QueryString["scope"] == "ClientAccepted") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/UnderWriters/Enquiries.aspx?scope=ClientAccepted" style="width:155px;">Client Accepted</a></li>
    </ul>
   </div>
</div>
    <asp:GridView ID="gvEnquiries" runat="server" AllowPaging="True" 
        CssClass="table table-bordered" 
        onpageindexchanging="gvEnquiries_PageIndexChanging" 
        onrowdatabound="gvEnquiries_RowDataBound" Width="100%" 
        EmptyDataText="No Enquiries under this scope!">
    </asp:GridView>
</asp:Content>

