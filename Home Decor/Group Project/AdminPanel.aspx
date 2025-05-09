<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="AdminPanel.aspx.cs" Inherits="Group_Project.AdminPanel" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Admin Panel | Aura & Aesthetics</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder1" Runat="Server">
    <!-- Admin Panel Content -->
    <div class="container mt-5">
        <h2 class="text-center mt-5">Welcome to the Dashboard</h2>
        <h2 class="text-primary text-center mt-4 ">Admin</h2>
        <br />
    </div>
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="footerPlaceHolder1" Runat="Server"></asp:Content>
