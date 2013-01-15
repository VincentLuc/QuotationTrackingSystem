<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="New.aspx.cs" Inherits="Visits_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script type="text/javascript">
    $(function () {
        $(".txtCalendarx").datepicker({
            constrainInput: true,
            dateFormat: "dd-mm-yy",
            changeMonth: true,
            changeYear: true,
             minDate:0
        });
        $(".txtCalendar").attr("readonly", true);
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Visits</a><span class="divider">></span></li>
    <li><a class="active">New</a></li>
  </ul>
</div>
<h3>New Visit</h3>
<hr />
    <table style="width:35%;">
        <tr>
            <td align="left">
                Client Name</td>
            <td>
                <asp:TextBox ID="txtClientName" runat="server" MaxLength="45"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvClientName" runat="server" 
                    ControlToValidate="txtClientName" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Contact Person</td>
            <td>
                <asp:TextBox ID="txtContactPerson" runat="server" MaxLength="45"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvContactPerson" runat="server" 
                    ControlToValidate="txtContactPerson" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Designation</td>
            <td>
                <asp:TextBox ID="txtDesignation" runat="server" MaxLength="45"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDesignation" runat="server" 
                    ControlToValidate="txtDesignation" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Phone</td>
            <td>
                <asp:TextBox ID="txtPhone" runat="server" MaxLength="45"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" 
                    ControlToValidate="txtPhone" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Line Of Insurance</td>
            <td>
                <asp:DropDownList ID="ddlLineOfInsurance" runat="server">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    <asp:ListItem Value="Motor">Motor</asp:ListItem>
                    <asp:ListItem Value="Medical">Medical</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvLineOfInsurance" runat="server" 
                    ControlToValidate="ddlLineOfInsurance" ForeColor="#FF3300" SetFocusOnError="True" 
                    InitialValue="0">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Status</td>
            <td>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    <asp:ListItem Value="ComeLater">Come Later</asp:ListItem>
                    <asp:ListItem Value="Declined">Declined</asp:ListItem>
                    <asp:ListItem Value="AskedQuotation">Asked Quotation</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvStatus" runat="server" 
                    ControlToValidate="ddlStatus" ForeColor="#FF3300" SetFocusOnError="True" 
                    InitialValue="0">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Policy Start At</td>
            <td>
                <asp:TextBox ID="txtPolicyStartAt" runat="server" CssClass="txtCalendar"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPolicyStartAt" runat="server" 
                    ControlToValidate="txtPolicyStartAt" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Remarks</td>
            <td>
                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRemarks" runat="server" 
                    ControlToValidate="txtRemarks" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center">
                <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save" />
            </td>
            <td>
                <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                    onclick="btnCancel_Click" Text="Cancel" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

