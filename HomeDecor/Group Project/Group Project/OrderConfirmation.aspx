<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="OrderConfirmation.aspx.cs" Inherits="Group_Project.OrderConfirmation" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Order Confirmation | Aura & Aesthetics</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder1" Runat="Server">
    <div class="container mt-5 mb-5">
        <div class="text-center">
            <h2 class="text-success">Thank You for Your Order!</h2>
            <p class="mt-3">Your order has been placed successfully.</p>
        </div>
        
        <div class="text-center mt-4">
            <a href="product" class="btn btn-primary">Continue Shopping</a>
        </div>
    </div>
</asp:Content>
