<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="New.aspx.cs" Inherits="Enquiries_New" MaintainScrollPositionOnPostback="true" %>
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
<style type="text/css">
    #MainContent_rbtnInsurance
    {
        margin-left: 9px;
    }
    #MainContent_rbtnInsurance label
    {
        display: inline;
        margin: 0 13px 0  7px;
    }
    .left-custom, .right-custom
    {
        width: 49%;
    }
    table textarea{
      width: 209px;
      height: 100px;
    }
    .left-custom {
        float:left;
    }
    .right-custom {
        float:right;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Index.aspx">Enquiries</a><span class="divider">></span></li>
    <li><a class="active">New</a></li>
  </ul>
</div>
<fieldset>
  <legend>New Enquiry</legend>
  <div class="left-custom">
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
    <label>Phone 1</label>
    <asp:TextBox ID="txtPhone1" runat="server" MaxLength="45"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvPhone1" runat="server" 
                    ControlToValidate="txtPhone1" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Phone 2</label>
    <asp:TextBox ID="txtPhone2" runat="server" MaxLength="45"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvPhone2" runat="server" 
                    ControlToValidate="txtPhone2" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
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
    <label>Intended Policy Start At</label>
    <asp:TextBox ID="txtIntendedPolicyStartAt" runat="server" MaxLength="45" CssClass="txtCalendar"></asp:TextBox>
  </p>
  </div>
  <div class="right-custom">
  <p>
    <label>Underwriter</label>
      <asp:DropDownList ID="ddlUnderwriterId" runat="server" 
          DataSourceID="SqlDataSource1" DataTextField="UserName" DataValueField="Id" 
          AppendDataBoundItems="True">
          <asp:ListItem Value="0">Select</asp:ListItem>
      </asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfvUnderWriterId" runat="server" 
                    ControlToValidate="ddlUnderwriterId" ForeColor="#FF3300" 
                    SetFocusOnError="True" InitialValue="0">*</asp:RequiredFieldValidator>
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
          ConnectionString="<%$ ConnectionStrings:QuotationTrackingSystemDBConnectionString %>" 
          SelectCommand="SELECT [Id], [UserName] FROM [tblUsers] WHERE ([Role] = @Role)">
          <SelectParameters>
              <asp:Parameter DefaultValue="UnderWriter" Name="Role" Type="String" />
          </SelectParameters>
      </asp:SqlDataSource>
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
    <label>Insurance For</label>
      <asp:RadioButtonList ID="rbtnInsurance" runat="server" AutoPostBack="True" 
          onselectedindexchanged="rbtnInsurance_SelectedIndexChanged" 
          RepeatDirection="Horizontal">
          <asp:ListItem>Individual</asp:ListItem>
          <asp:ListItem>Corporate</asp:ListItem>
      </asp:RadioButtonList>
  </p>
  <p id="individual" runat="server">
    <label>National Id / Iqama Number</label>
      <asp:TextBox ID="txtNationalIdOrIqamaNumber" runat="server"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvNationalIdOrIqamaNumber" runat="server"  ControlToValidate="txtNationalIdOrIqamaNumber" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p id="corporate" runat="server">
  <label>CR Number</label>
      <asp:TextBox ID="txtCrNumber" runat="server"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvCRNumber" runat="server"  
          ControlToValidate="txtCrNumber" ForeColor="#FF3300" SetFocusOnError="True" 
          Enabled="False">*</asp:RequiredFieldValidator>
  </p>
  <p>
  <label>Copy of CR*</label>
  <input type="file" id="fileCRCopy" name="fileCRCopy" />
  </p>
  <p>
  <label>Previous Loss Ratio Report</label>
  <input type="file" id="filePreviousLossRatioReport" name="filePreviousLossRatioReport" />
  </p>
  <p>
  <label>Additional Documents</label>
  <input type="file" id="fileAdditionalDocuments" name="fileAdditionalDocuments" />
  </p>
  <p>
      <asp:Button ID="btnSave" runat="server" Text="Save and Send to Under writer" CssClass="btn" 
          onclick="btnSave_Click" />
      &nbsp;
      <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
          onclick="btnCancel_Click" CausesValidation="False" />
  </p>
  </div>
  <div class="clear"></div>
</fieldset>
</asp:Content>

