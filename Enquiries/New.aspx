<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="New.aspx.cs" Inherits="Enquiries_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
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
      <asp:DropDownList ID="ddlInuranceType" runat="server">
          <asp:ListItem Value="0">Select</asp:ListItem>
          <asp:ListItem>Motor</asp:ListItem>
          <asp:ListItem Value="GroupMedical">Group Medical</asp:ListItem>
          <asp:ListItem>Property</asp:ListItem>
          <asp:ListItem Value="GeneralAccident">General Accident</asp:ListItem>
          <asp:ListItem>Marine</asp:ListItem>
          <asp:ListItem>Engineering</asp:ListItem>
      </asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfvInuranceType" runat="server" 
                    ControlToValidate="ddlInuranceType" ForeColor="#FF3300" 
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
  </p>
  <p>
  <label>Loss Ratio Report</label>
  <input type="file" id="fileLossRatioReport" name="fileLossRatioReport" />
  </p>
  <p>
      <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" 
          onclick="btnSave_Click" />
      &nbsp;
      <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" 
          onclick="btnCancel_Click" />
  </p>
</fieldset>
</asp:Content>

