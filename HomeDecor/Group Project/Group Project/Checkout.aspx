<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="Checkout.aspx.cs" Inherits="Group_Project.Checkout" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Checkout | Aura & Aesthetics</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder1" runat="Server">
    <!-- Checkout Page  Content -->
    <div class="container mt-5 mb-5" id="checkout-info-div">

        <div class="container mt-4">
            <!-- Billing Information -->
            <div class="col-md-6" id="billing-info">
                <h4 class="text-success text-center">Billing Information</h4>

                <!-- First Name -->
                <asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                    ErrorMessage="First Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="text-warning"
                    ValidationExpression="^[A-Za-z]+$" ErrorMessage="First name must contain alphabets only"
                    ControlToValidate="txtFirstName"></asp:RegularExpressionValidator>

                <!-- Last Name -->
                <asp:Label ID="lblLastName" runat="server" Text="Last Name" CssClass="d-block mt-3"></asp:Label>
                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName"
                    ErrorMessage="Last Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                    ValidationExpression="^[A-Za-z]+$" ControlToValidate="txtLastName"
                    ErrorMessage="Last name must contain alphabets only" CssClass="text-warning"></asp:RegularExpressionValidator>

                <!-- Email -->
                <asp:Label ID="lblEmail" runat="server" Text="Email Address" CssClass="d-block mt-3"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Invalid email format" CssClass="text-warning mb-3"
                    ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"></asp:RegularExpressionValidator>
            </div>

            <!-- Shipping Details -->
            <div class="col-md-6" id="shipping-info">
                <h4 class="text-success text-center mt-5">Shipping Details</h4>

                <!-- Address -->
                <asp:Label ID="lblAddress" runat="server" Text="Shipping Address"></asp:Label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress"
                    ErrorMessage="Address is required" CssClass="text-danger"></asp:RequiredFieldValidator>

                <!-- City -->
                <asp:Label ID="lblCity" runat="server" Text="City" CssClass="d-block mt-3"></asp:Label>
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity"
                    ErrorMessage="City is required" CssClass="text-danger mb-3"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                    ValidationExpression="^[A-Za-z]+$" CssClass="text-warning" ControlToValidate="txtCity"
                    ErrorMessage="City must contain alphabets only"></asp:RegularExpressionValidator>

                <!-- Zip Code -->
                <asp:Label ID="lblZipCode" runat="server" Text="Zip Code" CssClass="d-block mt-3"></asp:Label>
                <asp:TextBox ID="txtZipCode" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvZipCode" runat="server" ControlToValidate="txtZipCode"
                    ErrorMessage="Zip Code is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revZipCode" runat="server" ControlToValidate="txtZipCode"
                    ErrorMessage="Zip Code must be in the format 12345-1234" CssClass="text-warning mb-3"
                    ValidationExpression="^\d{5}(-\d{4})?$"></asp:RegularExpressionValidator>
            </div>
        </div>

        <div class="container mt-4">
            <!-- Payment Information -->
            <div class="col-md-6" id="payment-info">
                <h4 class="text-success text-center mt-5">Payment Information</h4>

                <!-- Card Number -->
                <asp:Label ID="lblCardNumber" runat="server" Text="Card Number" CssClass="d-block mt-3"></asp:Label>
                <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" ControlToValidate="txtCardNumber"
                    ErrorMessage="Card Number is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revCardNumber" runat="server"
                    ControlToValidate="txtCardNumber"
                    ValidationExpression="^\d{16}$"
                    ErrorMessage="Card Number must be exactly 16 digits"
                    CssClass="text-warning mb-3">
                </asp:RegularExpressionValidator>

                <!-- Expiry Date -->
                <asp:Label ID="lblExpiryDate" runat="server" Text="Expiry Date (MM/YY)" CssClass="d-block mt-3"></asp:Label>
                <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" placeholder="MM/YY"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvExpiryDate" runat="server" ControlToValidate="txtExpiryDate"
                    ErrorMessage="Expiry Date is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revExpiryDate" runat="server"
                    ControlToValidate="txtExpiryDate"
                    ValidationExpression="^(0[1-9]|1[0-2])\/\d{2}$"
                    ErrorMessage="Enter a valid Expiry Date in MM/YY format"
                    CssClass="text-warning">
                </asp:RegularExpressionValidator>

                <!-- CVV -->
                <asp:Label ID="lblCVV" runat="server" Text="CVV" CssClass="d-block mt-3"></asp:Label>
                <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" MaxLength="3"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCVV" runat="server" ControlToValidate="txtCVV"
                    ErrorMessage="CVV is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revCVV" runat="server"
                    ControlToValidate="txtCVV"
                    ValidationExpression="^\d{3}$"
                    ErrorMessage="CVV must be exactly 3 digits"
                    CssClass="text-warning mb-3">
                </asp:RegularExpressionValidator>
            </div>

            <!-- Order Summary -->
            <div class="text-center mt-2">
                <asp:Button ID="btnCheckout" runat="server" Text="Place Order" CssClass="btn btn-primary mt-3"
                    OnClick="btnCheckout_Click" />
            </div>
        </div>
    </div>
    
</asp:Content>

