<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Details.aspx.cs" Inherits="Emails_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="breadcrumb">
  <ul>
    <li><a href="Inbox.aspx">Emails</a><span class="divider">></span></li>
    <li><a class="active">Details</a></li>
  </ul>
</div>
<fieldset>
 <legend>Email Details</legend>
  <p>
    <span class="custom-text">Recieved At: </span>
    &nbsp;
    <%= DateTimeHelper.To24Hours(email.CreatedAt) %>
  </p>
  <p>
    <span class="custom-text">From:</span>
    &nbsp;
    <%= email.FromUserName %>
  </p>
  <p>
    <span class="custom-text">Subject: </span>
    &nbsp;
    <%= email.Subject %>
  </p>
  <p>
    <span class="custom-text">Body:</span>
    <br />
    <%= email.Body %>
  </p>
</fieldset>
</asp:Content>

