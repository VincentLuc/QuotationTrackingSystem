<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="SalesSupervisor_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3 class="left">Sales user details visits !</h3>
<div class="right">
    <asp:HiddenField ID="hdnFldSalesUserId" runat="server" />
<asp:TextBox ID="txtQueryDate" runat="server" CssClass="txtCalendar"></asp:TextBox>
    <asp:Button ID="btnSearch" runat="server" onclick="btnSearch_Click" 
        Text="Search" class="btn btn-primary" />
</div>
<script type="text/javascript">
    $(function () {
        $(".txtCalendar").datepicker({
            constrainInput: true,
            dateFormat: "dd-mm-yy",
            changeMonth: true,
            changeYear: true
        });
        $(".txtCalendar").attr("readonly", true);
    });
</script>
<div class="clear"></div>
<hr />
<div class="clear"></div>
    <asp:GridView ID="gvVisitDetails" runat="server" AllowPaging="True" 
        CssClass="table table-bordered" EmptyDataText="No Visits for this search criteria !" 
        onpageindexchanging="gvVisitDetails_PageIndexChanging" Width="100%">
    </asp:GridView>
</asp:Content>

