<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Group_Project.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | Aura & Aesthetics</title>

    <script src="Scripts/jquery-3.7.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/styles.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body id="login-main-container">
    <form id="form1" runat="server">

        <!-- Login Form Content -->
        <div class="container mt-5">
            <div class="row">
                <!-- First column for Login Form -->
                <div class="col-md-6 col-sm-11 col-xs-11" id="login-input">
                    <h3 class="text-center mt-5 mb-4" id="login-heading">Login</h3>

                    <asp:Label ID="lblError" runat="server" CssClass="text-danger" />

                    <div class="clearfix form-group">
                        <label class="control-label col-md-2">Username</label>
                        <div class="">
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-12">
                            <!-- Required Field Validator -->
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                                ErrorMessage="Username is required" ControlToValidate="txtUsername"
                                Display="Dynamic" CssClass="text-warning"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="clearfix form-group">
                        <label class="control-label col-md-2 mt-4">Password</label>
                        <div class="">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="col-md-12">
                            <!-- Required Field Validator -->
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                                ErrorMessage="Password is required" ControlToValidate="txtPassword"
                                Display="Dynamic" CssClass="text-warning"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="clearfix form-group">
                        <div class="text-center col-md-12 mt-4" id="login-buttons">
                            <asp:Button ID="Button1" runat="server" Text="Login" CssClass="btn btn-primary" OnClick="btnlogin_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
