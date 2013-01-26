<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FileUpload.aspx.cs" Inherits="FileUpload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 <input type="file" id="myFile" name="myFile" />
 <asp:Button runat="server" ID="btnUpload" OnClick="btnUploadClick" Text="Upload" class="btn" />
</asp:Content>

