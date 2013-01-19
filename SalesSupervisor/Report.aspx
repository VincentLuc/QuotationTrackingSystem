<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="SalesSupervisor_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script type="text/javascript">
    $(function () {
        
        function updateDatePickerOfToDate(minSelectedDate) {
            minSelectedDate.setDate(minSelectedDate.getDate());
            $(".toDate").datepicker('destroy');
            $(".toDate").datepicker({
                constrainInput: true,
                dateFormat: "dd-mm-yy",
                changeMonth: true,
                changeYear: true,
                minDate: minSelectedDate
            });
        }

        $(".fromDate").datepicker({
            constrainInput: true,
            dateFormat: "dd-mm-yy",
            changeMonth: true,
            changeYear: true,
            onSelect: function (dateText, inst) {
                var dateArray = dateText.split('-');
                var minSelectedDate = new Date(dateArray[2], parseInt(dateArray[1]) - 1, dateArray[0]);
                $(".toDate").val("");
                updateDatePickerOfToDate(minSelectedDate);
            }
        });

        $(".toDate").datepicker({
            constrainInput: true,
            dateFormat: "dd-mm-yy",
            changeMonth: true,
            changeYear: true
        });

        $(".fromDate, .toDate").attr("readonly", true);
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h3>Sales user details report !</h3>
<br />
<div class="left">
    <label style="display: inline-block;width: 231px;"> From Date </label>
    <label style="display: inline-block;"> To Date </label>
    <br />
    <asp:TextBox ID="txtFromDate" runat="server" CssClass="fromDate"></asp:TextBox>
    &nbsp;
    <asp:TextBox ID="txtToDate" runat="server" CssClass="toDate"></asp:TextBox>
    <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-primary" 
        onclick="btnSearch_Click" />
</div>
<div class="clear"></div>
<hr />
    <asp:GridView ID="gvVisitingReport" runat="server" AllowPaging="True" 
    CssClass="table table-bordered" 
    EmptyDataText="No Data for this search criteria !" 
    onpageindexchanging="gvVisitingReport_PageIndexChanging" Width="100%">
    </asp:GridView>
</asp:Content>

