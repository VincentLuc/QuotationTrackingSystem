<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="NotAuthorized.aspx.cs" Inherits="NotAuthorized" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <div class="alert alert-danger">
    <h4>You are not authorized to access that Page !</h4>
  </div>
</asp:Content>

