<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="Visits_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script type="text/javascript">
        $(function () {
            $(".txtCalendar").datepicker({
                constrainInput: true,
                dateFormat: "dd-mm-yy",
                changeMonth: true,
                changeYear: true,
                minDate: 0
            });
            $(".txtCalendar").attr("readonly", true);
        });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Visits</a><span class="divider">></span></li>
    <li><a class="active">Edit</a></li>
  </ul>
</div>
<fieldset>
  <legend>Edit Visit</legend>
  <p>
    <label>Client Name<asp:HiddenField ID="hdnVisitId" 
                    runat="server" />
     </label>
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
          <asp:ListItem>MOTOR - Comprehensive – Private/Commercial Vehicles</asp:ListItem>
          <asp:ListItem>MEDICAL</asp:ListItem>
          <asp:ListItem>PROPERTY - Fire + Allied Perils</asp:ListItem>
          <asp:ListItem>PROPERTY - Business Interruption following Fire</asp:ListItem>
          <asp:ListItem>PROPERTY - Business Interruption ff Fire & Allied Perils</asp:ListItem>
          <asp:ListItem>PROPERTY - Property All Risks</asp:ListItem>
          <asp:ListItem>PROPERTY - Business Interruption ff Property All Risks</asp:ListItem>
          <asp:ListItem>GENERAL ACCIDENT - Fidelity Guarantee</asp:ListItem>
          <asp:ListItem>GENERAL ACCIDENT - Money</asp:ListItem>
          <asp:ListItem>GENERAL ACCIDENT - Workmen Compensation</asp:ListItem>
          <asp:ListItem>GENERAL ACCIDENT - Medical Malpractice</asp:ListItem>
          <asp:ListItem>GENERAL ACCIDENT - Personal Accident</asp:ListItem>
          <asp:ListItem>GENERAL ACCIDENT - Public Liability</asp:ListItem>
          <asp:ListItem>GENERAL ACCIDENT - Comp General Liability – Occurrence Basis</asp:ListItem>
          <asp:ListItem>GENERAL ACCIDENT - Travel Insurance</asp:ListItem>
          <asp:ListItem>MARINE - Marine Caro – Single Shipment</asp:ListItem>
          <asp:ListItem>MARINE - Marine Cargo – Open Policy</asp:ListItem>
          <asp:ListItem>MARINE - Land Transit – Single Shipment</asp:ListItem>
          <asp:ListItem>MARINE - Land Transit – Open Policy</asp:ListItem>
          <asp:ListItem>MARINE - Goods in Transit – One year cover</asp:ListItem>
          <asp:ListItem>ENGINEERING - Contractors’ All Risks</asp:ListItem>
          <asp:ListItem>ENGINEERING - Contractors Plant & Equipment</asp:ListItem>
          <asp:ListItem>ENGINEERING - Deterioration of Stocks</asp:ListItem>
          <asp:ListItem>ENGINEERING - Erection All Risks</asp:ListItem>
          <asp:ListItem>ENGINEERING - Machinery Breakdown</asp:ListItem>
          <asp:ListItem>ENGINEERING - Loss of Profit ff Machinery Breakdown</asp:ListItem>
          <asp:ListItem>ENGINEERING - Electronic Equipment</asp:ListItem>
          <asp:ListItem>ENGINEERING - Boiler & Pressure Vessel</asp:ListItem>
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
</fieldset>
</asp:Content>

