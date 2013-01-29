<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="Enquiries_Edit" %>

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
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Enquiries</a><span class="divider">></span></li>
    <li><a href="Details.aspx?id=<%= enquiry.Id %>">Enquiry</a><span class="divider">></span></li>
    <li><a class="active">New</a></li>
  </ul>
</div>
<fieldset>
  <legend>Edit Enquiry</legend>
  <p>
      <asp:HiddenField ID="hdnEnquiryId" runat="server" />
    <label>Underwriter</label>
      <asp:DropDownList ID="ddlUnderwriterId" runat="server">
      </asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfvUnderWriterId" runat="server" 
                    ControlToValidate="ddlUnderwriterId" ForeColor="#FF3300" 
                    SetFocusOnError="True" InitialValue="0">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Type of Insurance</label>
      <asp:DropDownList ID="ddlInsuranceType" runat="server">
          <asp:ListItem Value="0">Select</asp:ListItem>
          <asp:ListItem>Motor</asp:ListItem>
          <asp:ListItem Value="GroupMedical">Group Medical</asp:ListItem>
          <asp:ListItem>Property</asp:ListItem>
          <asp:ListItem Value="GeneralAccident">General Accident</asp:ListItem>
          <asp:ListItem>Marine</asp:ListItem>
          <asp:ListItem>Engineering</asp:ListItem>
      </asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfvInsuranceType" runat="server" 
                    ControlToValidate="ddlInsuranceType" ForeColor="#FF3300" 
                    SetFocusOnError="True" InitialValue="0">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Client Name</label>
    <asp:TextBox ID="txtClientName" runat="server" MaxLength="45"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvClientName" runat="server" 
                    ControlToValidate="txtClientName" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Contact Person Name</label>
    <asp:TextBox ID="txtContactPersonName" runat="server" MaxLength="45"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvContactPersonName" runat="server" 
                    ControlToValidate="txtContactPersonName" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Phone</label>
    <asp:TextBox ID="txtPhone" runat="server" MaxLength="45"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" 
                    ControlToValidate="txtPhone" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Policy Start At</label>
    <asp:TextBox ID="txtPolicyStartAt" runat="server" MaxLength="45" CssClass="txtCalendar"></asp:TextBox>
  </p>
  <p>
    <label>Address</label>
    <asp:TextBox ID="txtAddress" runat="server" MaxLength="45" TextMode="MultiLine"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" 
                    ControlToValidate="txtAddress" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Remarks</label>
    <asp:TextBox ID="txtRemarks" runat="server" MaxLength="45" TextMode="MultiLine"></asp:TextBox>
  </p>
  <p>
  <label>Copy of CR*</label>
  <input type="file" id="fileCRCopy" name="fileCRCopy" />
  <br />
  <i>Leave it blank if you dont want to change or Select new to replace old one !</i>
  </p>
  <p>
  <label>Loss Ratio Report</label>
  <input type="file" id="fileLossRatioReport" name="fileLossRatioReport" />
  <br />
  <i>Leave it blank if you dont want to change or Select new to replace old one !</i>
  </p>
  <p>
      <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" 
          onclick="btnSave_Click" />
      &nbsp;
      <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
          onclick="btnCancel_Click" CausesValidation="False" />
  </p>
</fieldset>
</asp:Content>

