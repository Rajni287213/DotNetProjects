<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="Cart.aspx.cs" Inherits="Group_Project.Cart" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Cart | Aura & Aesthetics</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder1" runat="Server">
    <div class="container mt-5">
        <h2 class="text-center mb-5">Your Shopping Bag</h2>

        <div id="cart-list" class="container mb-5">
            <!-- Repeater control to display each cart item -->
            <asp:Repeater ID="CartRepeater" runat="server" OnItemCommand="CartRepeater_ItemCommand">
                <HeaderTemplate>
                    <table class="table table-bordered table-responsive">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("Name") %></td>
                        <td><%# Eval("Price", "{0:C}") %></td>
                        <td>
                            <div class="input-group">
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control"
                                             Text='<%# Eval("Quantity") %>' Width="50px" />
                                <div class="input-group-append ml-2">
                                    <!-- Button to update the quantity of the product -->
                                    <asp:Button ID="btnUpdateQuantity" runat="server" Text="Update" 
                                                CommandName="UpdateQuantity" 
                                                CommandArgument='<%# Eval("ProductID") %>' CssClass="btn btn-primary btn-sm" />
                                </div>
                            </div>
                        </td>
                        <td><%# Eval("Total", "{0:C}") %></td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="Remove"
                                            CommandArgument='<%# Eval("ProductID") %>' CssClass="btn btn-link text-danger"
                                            OnClientClick="return confirm('Are you sure you want to remove this item?');">
                                <i class="fas fa-trash"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>

        <!-- Alert message when the cart is empty -->
        <div class="alert alert-dismissible alert-secondary" runat="server" id="emptyCartAlert">
            <asp:Literal ID="NoProductsMessage" runat="server" Text="No products available" />
        </div>

        <!-- Display the cart total (subtotal of the cart items) -->
        <div class="d-flex mt-4">
            <div class="mr-3"><strong>Sub Total: </strong></div>
            <div>
                <asp:Label ID="lblCartTotal" runat="server" CssClass="text-success" Font-Bold="true" />
            </div>
        </div>

        <!-- Error Message -->
        <div class="mt-3">
            <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
        </div>

        <!-- Cart Actions -->
        <div class="d-flex justify-content-evenly mt-4 mb-5">
            <a href="product" class="btn btn-secondary">Continue Shopping</a>
            <asp:Button ID="btnProceedToCheckout" runat="server" Text="Proceed to Checkout" 
                        CssClass="btn btn-secondary" PostBackUrl="~/shop/checkout" />
        </div>
    </div>
</asp:Content>


