<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Enquiries_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <h3 class="right">
    <a href="New.aspx">New Enquiry</a>
  </h3>
  <div class="clear"></div>
  <hr />
  <div class="navbar">
  <div class="navbar-inner" style="height:47px;">
    <ul class="nav" style="width:100%;">
      <li class="<%= (Request.QueryString["scope"] == null || Request.QueryString["scope"] == "all") ? "active" : "" %>"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=all">All</a></li>
      <li class="<%= (Request.QueryString["scope"] == "New") ? "active" : "" %>"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=New">New</a></li>
      <li class="<%= (Request.QueryString["scope"] == "UnderwriterDeclined") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=UnderwriterDeclined" style="width:155px;">Underwriter Declined</a></li>
      <li class="<%= (Request.QueryString["scope"] == "AdditionalInformation") ? "active" : "" %>" style="width:165px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=AdditionalInformation" style="width:155px;">Additional information</a></li>
      <li class="<%= (Request.QueryString["scope"] == "MissingInformation") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=MissingInformation" style="width:155px;">Missing information</a></li>
      <li class="<%= (Request.QueryString["scope"] == "InformationUpdate") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=InformationUpdate" style="width:155px;">Informartion Updated</a></li>
      <li class="<%= (Request.QueryString["scope"] == "QuotationReleased") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=QuotationReleased" style="width:155px;">Released Quotation</a></li>
      <li class="<%= (Request.QueryString["scope"] == "ClientDeclined") ? "active" : "" %>" style="width:121px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=ClientDeclined" style="width:155px;">Client Declined</a></li>
      <li class="<%= (Request.QueryString["scope"] == "ClientAccepted") ? "active" : "" %>" style="width:155px;"><a href="/QuotationTrackingSystem/Enquiries/Index.aspx?scope=ClientAccepted" style="width:155px;">Client Accepted</a></li>
    </ul>
   </div>
</div>
    <asp:HiddenField ID="hdnScope" runat="server" />
    <asp:GridView ID="gvEnquiries" runat="server" AllowPaging="True" 
        EmptyDataText="No Enquiries under this scope!" 
        onpageindexchanging="gvEnquiries_PageIndexChanging" 
        onrowdatabound="gvEnquiries_RowDataBound" Width="100%" 
        CssClass="table table-bordered">
    </asp:GridView>

</asp:Content>

