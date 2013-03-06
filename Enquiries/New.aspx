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
    <asp:HiddenField ID="hdnCurrentUserId" runat="server" />
<fieldset>
  <legend>New Enquiry</legend>
  <div class="left-custom">
  <p>
    <label>Client Name</label>
    <asp:TextBox ID="txtClientName" runat="server" MaxLength="300"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvClientName" runat="server" 
                    ControlToValidate="txtClientName" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Contact Person Name</label>
    <asp:TextBox ID="txtContactPersonName" runat="server" MaxLength="300"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvContactPersonName" runat="server" 
                    ControlToValidate="txtContactPersonName" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Phone 1</label>
    <asp:TextBox ID="txtPhone1" runat="server" MaxLength="300"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvPhone1" runat="server" 
                    ControlToValidate="txtPhone1" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Phone 2</label>
    <asp:TextBox ID="txtPhone2" runat="server" MaxLength="300"></asp:TextBox>
  </p>
  <p>
    <label>Address</label>
    <asp:TextBox ID="txtAddress" runat="server" MaxLength="495" TextMode="MultiLine"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" 
                    ControlToValidate="txtAddress" ForeColor="#FF3300" 
                    SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Remarks</label>
    <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine"></asp:TextBox>
  </p>
  <p>
    <label>Intended Policy Start At</label>
    <asp:TextBox ID="txtIntendedPolicyStartAt" runat="server" CssClass="txtCalendar"></asp:TextBox>
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
      <asp:TextBox ID="txtNationalIdOrIqamaNumber" runat="server" MaxLength="300"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvNationalIdOrIqamaNumber" runat="server"  ControlToValidate="txtNationalIdOrIqamaNumber" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
  </p>
  <p id="corporate" runat="server">
  <label>CR Number</label>
      <asp:TextBox ID="txtCrNumber" runat="server" MaxLength="300"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvCRNumber" runat="server"  
          ControlToValidate="txtCrNumber" ForeColor="#FF3300" SetFocusOnError="True" 
          Enabled="False">*</asp:RequiredFieldValidator>
  </p>
  <p>
  <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
          ConnectionString="<%$ ConnectionStrings:QuotationTrackingSystemDBConnectionString %>" 
          
          SelectCommand="SELECT [UserName], [Id] FROM [tblUsers] WHERE (([Id] &lt;&gt; @Id) AND ([Role] = @Role))">
          <SelectParameters>
              <asp:ControlParameter ControlID="hdnCurrentUserId" Name="Id" 
                  PropertyName="Value" Type="Int32" />
              <asp:Parameter DefaultValue="Sales" Name="Role" Type="String" />
          </SelectParameters>
      </asp:SqlDataSource>
    <label>Copy to Sales Users</label>
    <asp:ListBox ID="lstbxCopySales" runat="server" DataSourceID="SqlDataSource3" 
          DataTextField="UserName" DataValueField="Id" SelectionMode="Multiple"></asp:ListBox>
  </p>
  </div>
  <div class="right-custom">
  <p>
    <label>Underwriter</label>
      <asp:DropDownList ID="ddlUnderwriterId" runat="server" 
          DataSourceID="SqlDataSource1" DataTextField="UserName" DataValueField="Id" 
          AppendDataBoundItems="True" AutoPostBack="True">
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
    <label>Copy to Underwriter Users</label>
    <asp:ListBox ID="lstbxCopyUnderwriters" runat="server" 
          DataSourceID="SqlDataSource2" DataTextField="UserName" DataValueField="Id" 
          SelectionMode="Multiple"></asp:ListBox>
      <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
          ConnectionString="<%$ ConnectionStrings:QuotationTrackingSystemDBConnectionString %>" 
          SelectCommand="SELECT [Id], [UserName] FROM [tblUsers] WHERE (([Id] &lt;&gt; @Id) AND ([Role] = @Role))">
          <SelectParameters>
              <asp:ControlParameter ControlID="ddlUnderwriterId" Name="Id" 
                  PropertyName="SelectedValue" Type="Int32" />
              <asp:Parameter DefaultValue="UnderWriter" Name="Role" Type="String" />
          </SelectParameters>
      </asp:SqlDataSource>
  </p>
  <p>
    <label>Type of Insurance</label>
      <asp:DropDownList ID="ddlInsuranceType" runat="server">
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
    <asp:RequiredFieldValidator ID="rfvInsuranceType" runat="server" 
                    ControlToValidate="ddlInsuranceType" ForeColor="#FF3300" 
                    SetFocusOnError="True" InitialValue="0">*</asp:RequiredFieldValidator>
  </p>
  <p>
    <label>Expected Premium</label>
    <asp:TextBox ID="txtExpectedPremium" runat="server"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvExpectedPremium" runat="server"  
          ControlToValidate="txtExpectedPremium" ForeColor="#FF3300" SetFocusOnError="True">*</asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="revExpectedPremium" runat="server" 
                    ControlToValidate="txtExpectedPremium" ForeColor="#FF3300" SetFocusOnError="True" 
                    ValidationExpression="^[0-9\.]+$">Enter in Correct Format</asp:RegularExpressionValidator>
  </p>
  <p>
  <label>Loss Ratio For <%= DateTime.Now.Year - 1 %></label>
  <asp:TextBox ID="txtLossRatioOne" runat="server" MaxLength="35"></asp:TextBox>
  <asp:RegularExpressionValidator ID="revLossRatioOne" runat="server" 
                    ControlToValidate="txtLossRatioOne" ForeColor="#FF3300" SetFocusOnError="True" 
                    ValidationExpression="^[0-9\.]*$">Enter in Correct Format</asp:RegularExpressionValidator>
  </p>
  <p>
  <label>Loss Ratio For <%= DateTime.Now.Year - 2 %></label>
  <asp:TextBox ID="txtLossRatioTwo" runat="server" MaxLength="35"></asp:TextBox>
  <asp:RegularExpressionValidator ID="revLossRationTwo" runat="server" 
                    ControlToValidate="txtLossRatioTwo" ForeColor="#FF3300" SetFocusOnError="True" 
                    ValidationExpression="^[0-9\.]*$">Enter in Correct Format</asp:RegularExpressionValidator>
  </p>
  <p>
  <label>Loss Ratio For <%= DateTime.Now.Year - 3 %></label>
  <asp:TextBox ID="txtLossRatioThree" runat="server" MaxLength="35"></asp:TextBox>
  <asp:RegularExpressionValidator ID="revLossRatioThree" runat="server" 
                    ControlToValidate="txtLossRatioThree" ForeColor="#FF3300" SetFocusOnError="True" 
                    ValidationExpression="^[0-9\.]*$">Enter in Correct Format</asp:RegularExpressionValidator>
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
  <label>Proposol Form / Additional Documents</label>
  <input type="file" id="fileAdditionalDocuments" name="fileAdditionalDocuments" />
  </p>
  <p>
      <asp:Button ID="btnSave" runat="server" Text="Save and Send to Under writer" CssClass="btn btn-primary" 
          onclick="btnSave_Click" />
      &nbsp;
      <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
          onclick="btnCancel_Click" CausesValidation="False" />
  </p>
  </div>
  <div class="clear"></div>
</fieldset>
</asp:Content>

