<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="New.aspx.cs" Inherits="Visits_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script type="text/javascript">
    $(function () {
        $(".txtCalendar").datepicker({
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
<fieldset>
<legend>New Visit</legend>
<p>
  <label>Client Name</label>
  <asp:TextBox ID="txtClientName" runat="server" MaxLength="45"></asp:TextBox>
  <asp:RequiredFieldValidator ID="rfvClientName" runat="server" 
                    ControlToValidate="txtClientName" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
</p>
<p>
  <label>Contact Person</label>
  <asp:TextBox ID="txtContactPerson" runat="server" MaxLength="45"></asp:TextBox>
  <asp:RequiredFieldValidator ID="rfvContactPerson" runat="server" 
                    ControlToValidate="txtContactPerson" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
</p>
<p>
  <label>Designation</label>
  <asp:TextBox ID="txtDesignation" runat="server" MaxLength="45"></asp:TextBox>
  <asp:RequiredFieldValidator ID="rfvDesignation" runat="server" 
                    ControlToValidate="txtDesignation" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
</p>
<p>
  <label>Phone</label>
  <asp:TextBox ID="txtPhone" runat="server" MaxLength="45"></asp:TextBox>
  <asp:RequiredFieldValidator ID="rfvPhone" runat="server" 
                    ControlToValidate="txtPhone" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
</p>
<p>
  <label>Line Of Insurance</label>
    <asp:DropDownList ID="ddlLineOfInsurance" runat="server">
    <asp:ListItem Value="0">Select</asp:ListItem>
    <asp:ListItem Value="Motor">Motor</asp:ListItem>
    <asp:ListItem Value="Medical">Medical</asp:ListItem>
  </asp:DropDownList>
  <asp:RequiredFieldValidator ID="rfvLineOfInsurance" runat="server" 
                    ControlToValidate="ddlLineOfInsurance" ForeColor="#FF3300" SetFocusOnError="True" 
                    InitialValue="0">*</asp:RequiredFieldValidator>
</p>
<p>
  <label>Status</label>
  <asp:DropDownList ID="ddlStatus" runat="server">
    <asp:ListItem Value="0">Select</asp:ListItem>
    <asp:ListItem Value="ComeLater">Come Later</asp:ListItem>
    <asp:ListItem Value="Declined">Declined</asp:ListItem>
    <asp:ListItem Value="AskedQuotation">Asked Quotation</asp:ListItem>
  </asp:DropDownList>
  <asp:RequiredFieldValidator ID="rfvStatus" runat="server" 
                    ControlToValidate="ddlStatus" ForeColor="#FF3300" SetFocusOnError="True" 
                    InitialValue="0">*</asp:RequiredFieldValidator>
</p>
<p>
  <label>Policy Start At</label>
  <asp:TextBox ID="txtPolicyStartAt" runat="server" CssClass="txtCalendar"></asp:TextBox>
  <asp:RequiredFieldValidator ID="rfvPolicyStartAt" runat="server" 
                    ControlToValidate="txtPolicyStartAt" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
</p>
<p>
  <label>Remarks</label>
  <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine"></asp:TextBox>
  <asp:RequiredFieldValidator ID="rfvRemarks" runat="server" 
                    ControlToValidate="txtRemarks" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
 </p>
 <p></p>
 <p>
   <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save"  CssClass="btn btn-save"/>
   <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                    onclick="btnCancel_Click" Text="Cancel"  CssClass="btn"/>
   </p>
 </fieldset>
</asp:Content>

