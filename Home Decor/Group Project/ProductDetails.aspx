<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="ProductDetails.aspx.cs" Inherits="Group_Project.ProductDetails" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Product Details | Aura & Aesthetics</title>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder1" runat="Server">
    <!-- Product Page Content -->
    <div class="container my-5">
        <h3 class="text-center mb-4">Product Details</h3>
         <div class="text-center">
     <asp:Label ID="lblSuccessMessage" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>
     <asp:Literal ID="SuccessMessageScript" runat="server"></asp:Literal>
 </div>
        <div id="product-details" class="row justify-content-center mt-5">
            <!-- Data Source -->
            <asp:SqlDataSource ID="sqlProductDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [ProductID], [Name], [UnitPrice], [ShortDescription], [LongDescription], [ImageFile] FROM [Products] WHERE ([ProductID] = @ProductID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <!-- Product Details Panel -->
            <asp:Panel ID="pnlProductDetail" runat="server" Visible="true" class="col-md-8">
                <div class="row g-4 align-items-center shadow   ">
                    <!-- Image Section -->
                    <div class="col-md-5">
                        <asp:Image ID="imgProduct" runat="server" CssClass="img-fluid rounded shadow-sm" />
                    </div>

                    <!-- Details Section -->
                    <div class="col-md-7">
                        <div class="card border-0">
                            <div class="card-body">
                                <h3 class="card-title fw-bold text-primary">
                                    <asp:Label ID="lblProductName" runat="server"></asp:Label>
                                </h3>
                                <p class="card-text">
                                    <asp:Label ID="lblProductDescription" runat="server"></asp:Label>
                                </p>
                                <h3 class=" fw-bold mb-3 card-text lead">
                                    <asp:Label ID="lblProductPrice" runat="server"></asp:Label>
                                </h3>
                                <p class="card-text">
                                    <asp:Label ID="lblLongProductDescription" runat="server" ></asp:Label>
                                </p>
                                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" 
                                    CssClass="btn btn-primary btn-lg mt-4" OnClick="btnAddToCart_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <!-- Error Message -->
            <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger fw-bold mt-3" Visible="false"></asp:Label>
        </div>
    </div>

    <!-- Optional: Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

