<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="CategoryList.aspx.cs" Inherits="Group_Project.CategoryList" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>CategoryList | Aura & Aesthetics</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder1" runat="Server">

    <div class="container mt-5">
        <h2 class="text-primary text-center mt-5">Category List</h2>

        <%--category list --%>
        <div class="form-group mt-4">
            <div id="category-list">

                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    DeleteCommand="DELETE FROM [Category] WHERE [CategoryID] = @CategoryID"
                    InsertCommand="INSERT INTO [Category] ([CategoryID], [Category]) VALUES (@CategoryID, @Category)"
                    SelectCommand="SELECT [CategoryID], [Category] FROM [Category] ORDER BY [CategoryID]"
                    UpdateCommand="UPDATE [Category] SET [Category] = @Category WHERE [CategoryID] = @CategoryID">

                    <DeleteParameters>
                        <asp:Parameter Name="CategoryID" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="CategoryID" Type="String" />
                        <asp:Parameter Name="Category" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Category" Type="String" />
                        <asp:Parameter Name="CategoryID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <!-- Label for Error Messages -->
                <asp:Label ID="lblError_categoryList" runat="server" CssClass="text-danger"></asp:Label>

                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CellPadding="4" DataKeyNames="CategoryID" DataSourceID="SqlDataSource1" ForeColor="#333333"
                    GridLines="None" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowDeleted="GridView1_RowDeleted" OnRowUpdated="GridView1_RowUpdated">

                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" ReadOnly="True" SortExpression="CategoryID">
                            <ItemStyle CssClass="col-xs-3" />
                        </asp:BoundField>

                        <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category">
                            <ItemStyle CssClass="col-xs-3" />
                        </asp:BoundField>

                        <asp:CommandField ShowEditButton="True" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>

                    <EditRowStyle BackColor="#CCEDED" />
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

        <%--form to add a new genre--%>
        <div id="form-category" class="container mt-4 mb-5">
            <div class="row">
                <div class="col-xs-12 mt-4">
                    <asp:Label ID="Label2" runat="server" Text="Label">
                        <p><strong>To Create a New Category</strong></p>
                    </asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-12">

                    <div class="msg-div">
                        <asp:Label ID="lblSuccess_AddCategory" runat="server" CssClass="text-success"></asp:Label>
                        <asp:Label ID="lblError_AddCategory" runat="server" CssClass="text-danger"></asp:Label>
                    </div>

                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="CategoryID" DataSourceID="SqlDataSource1"
                        DefaultMode="Insert" CssClass="table table-bordered table-responsive" 
                        ValidationGroup="AddCategoryValidation" OnItemCommand="FormView1_ItemCommand" 
                        OnItemInserted="FormView1_Inserted" OnItemInserting="FormView1_ItemInserting">
                        
                        <EditItemTemplate>
                            <div class="form-group category-input">
                                <label for="IdLabel1" class="control-label">Category ID</label>
                                <asp:Label ID="IdLabel1" runat="server" Text='<%# Eval("CategoryID") %>' class="form-control-static"></asp:Label>
                            </div>
                            <div class="form-group category-input">
                                <label for="CategoryTextBox" class="control-label">Category</label>
                                <asp:TextBox ID="CategoryTextBox" runat="server" Text='<%# Bind("Category") %>' CssClass="form-control"></asp:TextBox>
                            </div>
                        </EditItemTemplate>

                        <InsertItemTemplate>
                            <div class="form-group category-input">
                                <label for="IdTextBox" class="control-label">Category ID</label>
                                <asp:TextBox ID="IdTextBox" runat="server" Text='<%# Bind("CategoryID") %>' CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ErrorMessage="Category ID is required" ControlToValidate="IdTextBox" CssClass="text-warning"
                                    ValidationGroup="AddCategoryValidation"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group genre-input">
                                <label for="CategoryTextBox" class="control-label">Category</label>
                                <asp:TextBox ID="CategoryTextBox" runat="server" Text='<%# Bind("Category") %>' CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ErrorMessage="Short Name is required" ControlToValidate="CategoryTextBox"
                                    CssClass="text-warning" ValidationGroup="AddCategoryValidation"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group text-center mt-3 mb-3">
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Insert"
                                    Text="Add New Category" CssClass="btn btn-success" ValidationGroup="AddCategoryValidation"></asp:LinkButton>
                            </div>
                        </InsertItemTemplate>

                        <ItemTemplate>
                            <div class="form-group category-input">
                                <label for="IdLabel" class="control-label">Category ID</label>
                                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("CategoryID") %>' class="form-control-static"></asp:Label>
                            </div>
                            <div class="form-group category-input">
                                <label for="CategoryLabel" class="control-label">Category</label>
                                <asp:Label ID="CategoryLabel" runat="server" Text='<%# Bind("Category") %>' class="form-control-static"></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:FormView>
                </div>
            </div>
        </div>

    </div>
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="footerPlaceHolder1" runat="Server"></asp:Content>
