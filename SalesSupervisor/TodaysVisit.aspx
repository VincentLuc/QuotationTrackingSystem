<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TodaysVisit.aspx.cs" Inherits="SalesSupervisor_TodaysVisit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3 class="left">Todays visit by Sales Person !</h3>
<div class="right">
    <asp:TextBox ID="txtQueryDate" runat="server" CssClass="txtCalendar"></asp:TextBox>
    <asp:Button ID="btnSearch" runat="server" onclick="btnSearch_Click" 
        Text="Search" class="btn btn-primary" />
    </div>
<div class="clear"></div>
<hr />
    <asp:GridView ID="gvTodaysSalesVisits" runat="server" AllowPaging="True" 
        CssClass="table table-bordered" Width="100%" 
        onpageindexchanging="gvTodaysSalesVisits_PageIndexChanging">
    </asp:GridView>
</asp:Content>

