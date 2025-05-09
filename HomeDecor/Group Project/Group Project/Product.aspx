<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="Product.aspx.cs" Inherits="Group_Project.Product" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Shop | Aura & Aesthetics</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder1" runat="Server">
    <!-- Product Page Content -->
    <div class="container mt-5">
        <h2 class="text-center mb-5">Shop Our Products</h2>

        <div class="text-center">
            <asp:Label ID="lblSuccessMessage" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>
            <asp:Literal ID="SuccessMessageScript" runat="server"></asp:Literal>
        </div>

        <!-- Dropdown for category selection -->
        <div class="form-group mt-5 mb-4" id="category-select">
            <strong>Choose a category:</strong>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [CategoryID], [Category] 
                            FROM [Category]
                            ORDER BY [CategoryID]"></asp:SqlDataSource>

            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" CssClass="form-select mt-3"
                DataSourceID="SqlDataSource1" DataTextField="Category" DataValueField="CategoryID"
                AppendDataBoundItems="True">
                <asp:ListItem Text="All Categories" Value="0" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <br />

        <!-- Product List -->
        <div id="product-list" class="container mb-5">
            <div class="row-product">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="SELECT [ProductID], [Name], [ShortDescription], [UnitPrice], [CategoryID], [ImageFile] 
                                FROM [Products] 
                                WHERE (@CategoryID = '0' OR [CategoryID] = @CategoryID)
                                ORDER BY [ProductID]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="CategoryID" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <!-- ListView for displaying products -->
                <asp:ListView ID="ProductDataList" runat="server" DataSourceID="SqlDataSource2">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                            <div class="pro-card">
                                <!-- Product Image -->
                                <asp:HyperLink ID="lnkProductDetails" runat="server" NavigateUrl='<%# "./shop/productDetails?ProductID=" + Eval("ProductID") %>'>
                                 <img class="pro-img" src='../images/<%# ResolveUrl(Eval("ImageFile").ToString()) %>' alt='Image of <%# Eval("Name") %>' />
                                </asp:HyperLink>

                                <!-- Product Details -->
                                <div class="pro-body">
                                    <h4 class="pro-title">
                                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "./shop/productDetails?ProductID=" + Eval("ProductID") %>'>
                                         <%# Eval("Name") %>
                                        </asp:HyperLink>
                                    </h4>
                                    <%--<p class="product-shortDescription"><%# Eval("ShortDescription") %></p>--%>
                                    <p class="product-price"><%# Eval("UnitPrice", "{0:C}") %></p>


                                    <asp:Button class="btn btn-primary" ID="AddToCart" runat="server" Text="Add to Cart"
                                        CommandName="AddToCart" CommandArgument='<%# Eval("ProductID") %>'
                                        OnClick="AddToCart_Click" />


                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
</asp:Content>      
