<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="SalesSupervisor_Details" %>

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
<div class="right">
<asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-primary" 
        onclick="btnBack_Click" />
</div>
<div class="clear"></div>
<hr />
<h3 class="left">Sales user details !</h3>
<table style="width:100%;" class="table table-bordered sales-user-details-table">
  <tr>
  <td>Name</td>
  <td><%= _tblUser.FirstName %> <%= _tblUser.MiddleName %> <%= _tblUser.LastName %></td>
  </tr>
  <tr>
  <td>User Name</td>
  <td><%= _tblUser.UserName %></td>
  </tr>
  <tr>
  <td>Status</td>
  <td><%= StringHelper.ToSentenceCase(_tblUser.Status.ToString()) %></td>
  </tr>
  <tr>
  <td>Sign in Count</td>
  <td><%= _tblUser.SignInCount%></td>
  </tr>
  <tr>
  <td>Last Sign in at</td>
  <td><%= DateTimeHelper.ConvertToString(_tblUser.LastSignInAt.ToString()) %></td>
  </tr>
  <tr>
  <td>Created At</td>
  <td><%= DateTimeHelper.ConvertToString(_tblUser.CreatedAt.ToString()) %></td>
  </tr>
</table>
<div class="clear"></div>
<hr />
<div class="left">
 <h3>Visit Details !</h3>
</div>
<div class="right">
    <asp:HiddenField ID="hdnFldSalesUserId" runat="server" />
<asp:TextBox ID="txtFromDate" runat="server" CssClass="fromDate"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvFromDate" runat="server" 
        ControlToValidate="txtFromDate" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
    &nbsp;&nbsp;
    <asp:TextBox ID="txtToDate" runat="server" CssClass="toDate"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvToDate" runat="server" 
        ControlToValidate="txtToDate" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        &nbsp;&nbsp;
    <asp:Button ID="btnSearch" runat="server" onclick="btnSearch_Click" 
        Text="Search" class="btn btn-primary" />
</div>
<div class="clear"></div>
    <asp:GridView ID="gvVisitDetails" runat="server" AllowPaging="True" 
        CssClass="table table-bordered" EmptyDataText="No Visits for this search criteria !" 
        onpageindexchanging="gvVisitDetails_PageIndexChanging" Width="100%">
    </asp:GridView>
</asp:Content>

