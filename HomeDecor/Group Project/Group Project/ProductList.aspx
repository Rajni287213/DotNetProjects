<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="ProductList.aspx.cs" Inherits="Group_Project.ProductList" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>ProductList | Aura & Aesthetics</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder1" runat="Server">

    <asp:Label ID="lblNoProducts" runat="server" CssClass="text-danger text-center d-block"></asp:Label>

    <!-- ProductList Content -->
    <div class="container mt-5">
        <h2 class="text-primary text-center mt-5">Product List</h2>

        <%--drop down list to select a Category--%>
        <div class="form-group mt-5" id="category-select">
            <strong>Choose a category:</strong>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT [CategoryID], [Category] 
                               FROM [Category] 
                               ORDER BY [CategoryID]"></asp:SqlDataSource>

            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" CssClass="form-select mt-3"
                DataSourceID="SqlDataSource1" DataTextField="Category" DataValueField="CategoryID">
            </asp:DropDownList>
        </div>


        <%--list of products based on the select category with select option--%>
        <div id="product-list" class="container">

            <div class="row">
                <!-- GridView Section - list of products of a category -->
                <div class="mt-4" id="gridView-productList">

                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                        SelectCommand="SELECT [ProductID], [Name], [CategoryID], [ShortDescription] 
                                       FROM [Products] 
                                       WHERE ([CategoryID] = @CategoryID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="CategoryID" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" AllowPaging="True"
                        DataKeyNames="ProductID" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None"
                        OnSelectedIndexChanged="GridView1_SelectedIndexChanged">

                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="ProductID" HeaderText="ProductID" ReadOnly="True" SortExpression="ProductID" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" SortExpression="CategoryID" />
                            <asp:CommandField ShowSelectButton="True" />
                        </Columns>

                        <EmptyDataTemplate>
                            <div class="text-center text-danger mt-3">
                                No products found for the selected category.
                            </div>
                        </EmptyDataTemplate>

                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>

                </div>
            </div>
        </div>

        <%--product details with CRUD (update & delete) operation using detailsView--%>
        <div id="product-details" class="container mt-4 mb-4">

            <div class="row">
                <!-- DetailsView Section - details of a single product -->
                <div class="" id="detailsView-productDetails">

                    <!-- It will show error or succcess message-->
                    <div class="msg-div">
                        <asp:Label ID="lblError_productDetails" runat="server" CssClass="text-danger"></asp:Label>
                        <asp:Label ID="lblSuccess_ProductUpdateDelete" runat="server" CssClass="text-success"></asp:Label>
                    </div>

                    <!-- SQL DataSource for performing CRUD Operation -->
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                        DeleteCommand="DELETE FROM [Products] WHERE [ProductID] = @ProductID"
                        InsertCommand="INSERT INTO [Products] ([ProductID], [Name], [ShortDescription], [LongDescription], [UnitPrice], [CategoryID], [ImageFile], [OnHand]) 
                                       VALUES (@ProductID, @Name, @ShortDescription, @LongDescription, @UnitPrice, @CategoryID, @ImageFile, @OnHand)"
                        SelectCommand="SELECT [ProductID], [Name], [ShortDescription], [LongDescription], [UnitPrice], [CategoryID], [ImageFile], [OnHand] 
                                       FROM [Products] 
                                       WHERE ([ProductID] = @ProductID)"
                        UpdateCommand="UPDATE [Products] 
                                       SET [Name] = @Name, [ShortDescription] = @ShortDescription, [LongDescription] = @LongDescription, [UnitPrice] = @UnitPrice, [CategoryID] = @CategoryID, [ImageFile] = @ImageFile, [OnHand] = @OnHand 
                                       WHERE [ProductID] = @ProductID">

                        <DeleteParameters>
                            <asp:Parameter Name="ProductID" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="ProductID" Type="String" />
                            <asp:Parameter Name="Name" Type="String" />
                            <asp:Parameter Name="ShortDescription" Type="String" />
                            <asp:Parameter Name="LongDescription" Type="String" />
                            <asp:Parameter Name="UnitPrice" Type="Decimal" />
                            <asp:Parameter Name="CategoryID" Type="String" />
                            <asp:Parameter Name="ImageFile" Type="String" />
                            <asp:Parameter Name="OnHand" Type="Int32" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="ProductID" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Name" Type="String" />
                            <asp:Parameter Name="ShortDescription" Type="String" />
                            <asp:Parameter Name="LongDescription" Type="String" />
                            <asp:Parameter Name="UnitPrice" Type="Decimal" />
                            <asp:Parameter Name="CategoryID" Type="String" />
                            <asp:Parameter Name="ImageFile" Type="String" />
                            <asp:Parameter Name="OnHand" Type="Int32" />
                            <asp:Parameter Name="ProductID" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4"
                        DataKeyNames="ProductID" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None"
                        OnItemCommand="DetailsView1_ItemCommand" OnItemDeleted="DetailsView1_ItemDeleted"
                        OnItemUpdated="DetailsView1_ItemUpdated" OnItemUpdating="DetailsView1_ItemUpdating">

                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                        <EditRowStyle BackColor="#999999" />
                        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                        <Fields>
                            <asp:BoundField DataField="ProductID" HeaderText="ProductID" ReadOnly="True" SortExpression="ProductID" ControlStyle-CssClass="form-control" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ControlStyle-CssClass="form-control" />
                            <asp:BoundField DataField="ShortDescription" HeaderText="ShortDescription" SortExpression="ShortDescription" ControlStyle-CssClass="form-control" />
                            <asp:BoundField DataField="LongDescription" HeaderText="LongDescription" SortExpression="LongDescription" ControlStyle-CssClass="form-control" />
                            <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice" DataFormatString="{0:c}" ControlStyle-CssClass="form-control" />
                           
                            <asp:TemplateField HeaderText="CategoryID" SortExpression="CategoryID">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                                        DataTextField="Category" DataValueField="CategoryID" SelectedValue='<%# Bind("CategoryID") %>' CssClass="form-control">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CategoryID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="ImageFile" SortExpression="ImageFile">
                                <EditItemTemplate>
                                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                                     <asp:Label ID="Label2" runat="server" Text='<%# Bind("ImageFile") %>' Visible="false"></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("ImageFile") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="OnHand" HeaderText="OnHand" SortExpression="OnHand" ControlStyle-CssClass="form-control" />
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        </Fields>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    </asp:DetailsView>

                </div>
            </div>
        </div>


        <%--form to add a new product--%>
        <div id="form-category" class="container mb-5">
            <div class="row">
                <div class="col-xs-12">
                    <asp:Label ID="Label2" runat="server" Text="Label"> <p><strong>To Create a New Product</strong></p></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-12">

                    <div class="msg-div">
                        <asp:Label ID="lblError_AddProduct" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
                        <asp:Label ID="lblSuccess_AddProduct" runat="server" CssClass="text-success" Visible="false" />
                    </div>

                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="ProductID" DataSourceID="SqlDataSource3"
                        DefaultMode="Insert" CssClass="table table-bordered" ValidationGroup="AddProductValidation"
                        OnItemInserting="ProductFormView_ItemInserting">

                        <EditItemTemplate>
                            <div class="form-group product-input">
                                <label for="IdLabel1" class="control-label">Product ID</label>
                                <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("ProductID") %>' class="form-control-static"></asp:Label>
                            </div>
                            <div class="form-group product-input">
                                <label for="NameTextBox" class="control-label">Name</label>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group product-input">
                                <label for="ShortDescriptionTextBox" class="control-label">Short Description</label>
                                <asp:TextBox ID="ShortDescriptionTextBox" runat="server" Text='<%# Bind("ShortDescription") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group product-input">
                                <label for="LongDescriptionTextBox" class="control-label">Long Description</label>
                                <asp:TextBox ID="LongDescriptionTextBox" runat="server" Text='<%# Bind("LongDescription") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group product-input">
                                <label for="UnitPriceTextBox" class="control-label">Unit Price</label>
                                <asp:TextBox ID="UnitPriceTextBox" runat="server" Text='<%# Bind("UnitPrice") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group product-input">
                                <label for="DropDownList2" class="control-label">Category ID</label>
                                <asp:DropDownList ID="DropDownList2" runat="server"></asp:DropDownList>
                            </div>
                            <div class="form-group product-input">
                                <label for="ImageFileTextBox" class="control-label">Image File</label>
                                <asp:TextBox ID="ImageFileTextBox" runat="server" Text='<%# Bind("ImageFile") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group product-input">
                                <label for="OnHandTextBox" class="control-label">On Hand</label>
                                <asp:TextBox ID="OnHandTextBox" runat="server" Text='<%# Bind("OnHand") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                        </EditItemTemplate>

                        <InsertItemTemplate>
                            <div class="form-group product-input">
                                <label for="IdTextBox" class="product-label">Product ID</label>
                                <asp:TextBox ID="IdTextBox" runat="server" Text='<%# Bind("ProductID") %>' CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ErrorMessage="Product ID is required" ControlToValidate="IdTextBox" CssClass="text-warning"
                                    ValidationGroup="AddProductValidation">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="IdTextBox"
                                    ValidationGroup="AddProductValidation" ErrorMessage="Only numbers are allowed"
                                    CssClass="text-warning" ValidationExpression="^\d+$"> 
                                </asp:RegularExpressionValidator>
                            </div>

                            <div class="form-group genre-input">
                                <label for="NameTextBox" class="control-label">Name</label>
                                <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ErrorMessage="Name is required" ControlToValidate="NameTextBox"
                                    CssClass="text-warning" ValidationGroup="AddProductValidation"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group product-input">
                                <label for="ShortDescriptionTextBox" class="control-label">Short Description</label>
                                <asp:TextBox ID="ShortDescriptionTextBox" runat="server" Text='<%# Bind("ShortDescription") %>' CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    ErrorMessage="Short Description is required" CssClass="text-warning"
                                    ValidationGroup="AddProductValidation" ControlToValidate="ShortDescriptionTextBox"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group product-input">
                                <label for="LongDescriptionTextBox" class="control-label">Long Description</label>
                                <asp:TextBox ID="LongDescriptionTextBox" runat="server" Text='<%# Bind("LongDescription") %>' CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                    ErrorMessage="Long Description is Required" ControlToValidate="LongDescriptionTextBox"
                                    CssClass="text-warning" ValidationGroup="AddProductValidation"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group product-input">
                                <label for="UnitPriceTextBox" class="control-label">Unit Price</label>
                                <asp:TextBox ID="UnitPriceTextBox" runat="server" Text='<%# Bind("UnitPrice") %>' CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                    ErrorMessage="Unit Proce is required" ControlToValidate="UnitPriceTextBox"
                                    CssClass="text-warning" ValidationGroup="AddProductValidation"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                    ErrorMessage="Please enter a valid price (only numeric values allowed)"
                                    ControlToValidate="UnitPriceTextBox"
                                    ValidationExpression="^\d+(\.\d{1,3})?$"
                                    CssClass="text-warning" ValidationGroup="AddProductValidation"></asp:RegularExpressionValidator>
                            </div>

                            <div class="form-group product-input">
                                <label for="DropDownList2" class="control-label">Category ID</label>
                                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                                    DataTextField="Category" DataValueField="CategoryID" SelectedValue='<%# Bind("CategoryID") %>'
                                    CssClass="form-select mb-3">
                                </asp:DropDownList>
                            </div>

                            <div class="form-group product-input">
                                <label for="FileUploadControl" class="control-label">Image File</label>
                                <asp:FileUpload ID="FileUploadControl" runat="server" CssClass="form-control mb-3" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                    ErrorMessage="Image uploading is required" ControlToValidate="FileUploadControl"
                                    CssClass="text-warning" ValidationGroup="AddProductValidation"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group product-input">
                                <label for="OnHandTextBox" class="control-label">On Hand</label>
                                <asp:TextBox ID="OnHandTextBox" runat="server" Text='<%# Bind("OnHand") %>' CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                    ErrorMessage="On hand is required" ControlToValidate="OnHandTextBox"
                                    CssClass="text-warning" ValidationGroup="AddProductValidation"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="OnHandTextBox"
                                    ValidationGroup="AddProductValidation" ErrorMessage="Please enter a valid number"
                                    CssClass="text-warning" ValidationExpression="^\d+$"> 
                                </asp:RegularExpressionValidator>
                            </div>

                            <div class="form-group text-center mt-3 mb-3">
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Insert"
                                    Text="Add New Product" CssClass="btn btn-success" ValidationGroup="AddProductValidation"></asp:LinkButton>
                            </div>
                        </InsertItemTemplate>

                        <ItemTemplate>
                            <div class="form-group product-input">
                                <label for="IdLabel" class="control-label">Product ID</label>
                                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("ProductID") %>' class="form-control-static"></asp:Label>
                            </div>
                            <div class="form-group product-input">
                                <label for="NameLabel" class="control-label">Name</label>
                                <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' class="form-control-static"></asp:Label>
                            </div>
                            <div class="form-group product-input">
                                <label for="ShortDescriptionTextBox" class="control-label">Short Description</label>
                                <asp:TextBox ID="ShortDescriptionTextBox" runat="server" Text='<%# Bind("ShortDescription") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group product-input">
                                <label for="LongDescriptionTextBox" class="control-label">Long Description</label>
                                <asp:TextBox ID="LongDescriptionTextBox" runat="server" Text='<%# Bind("LongDescription") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group product-input">
                                <label for="UnitPriceTextBox" class="control-label">Unit Price</label>
                                <asp:TextBox ID="UnitPriceTextBox" runat="server" Text='<%# Bind("UnitPrice") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group product-input">
                                <label for="DropDownList3" class="control-label">Category ID</label>
                                <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource1"></asp:DropDownList>
                            </div>
                            <div class="form-group product-input">
                                <label for="ImageFileTextBox" class="control-label">Image File</label>
                                <asp:TextBox ID="ImageFileTextBox" runat="server" Text='<%# Bind("ImageFile") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group product-input">
                                <label for="OnHandTextBox" class="control-label">On Hand</label>
                                <asp:TextBox ID="OnHandTextBox" runat="server" Text='<%# Bind("OnHand") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                        </ItemTemplate>
                    </asp:FormView>

                </div>
            </div>
        </div>

    </div>
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="footerPlaceHolder1" runat="Server"></asp:Content>
