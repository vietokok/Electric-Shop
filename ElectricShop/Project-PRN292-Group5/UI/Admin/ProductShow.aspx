<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Admin/Admin1.Master" AutoEventWireup="true" CodeBehind="ProductShow.aspx.cs" Inherits="Project_PRN292_Group5.UI.Admin.ProductShow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 161px;
        }

        .auto-style2 {
            width: 61px;
        }

        .auto-style3 {
            width: 938px;
        }

        .auto-style4 {
            width: 161px;
            height: 25px;
        }

        .auto-style5 {
            width: 61px;
            height: 25px;
        }

        .auto-style6 {
            width: 938px;
            height: 25px;
        }

        .auto-style7 {
            width: 161px;
            height: 26px;
        }

        .auto-style8 {
            width: 61px;
            height: 26px;
        }

        .auto-style9 {
            width: 938px;
            height: 26px;
        }

        .auto-style10 {
            width: 161px;
            height: 27px;
        }

        .auto-style11 {
            width: 61px;
            height: 27px;
        }

        .auto-style12 {
            width: 938px;
            height: 27px;
        }

        .auto-style13 {
            width: 161px;
            height: 29px;
        }

        .auto-style14 {
            width: 61px;
            height: 29px;
        }

        .auto-style15 {
            width: 938px;
            height: 29px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mx-auto" style="width: 200px;">
        <h3><span class="badge badge-danger mb-2">PRODUCTS</span></h3>
    </div>
    <div class="input-group mb-3">
        <asp:TextBox ID="TextBox1" runat="server" CssClass="mb-3 form-control" placeholder="Search..." Style="margin-bottom: 0px"></asp:TextBox>
        <div class="input-group-append">
            <asp:Button ID="Button1" Style="height: calc(1.5em + .75rem + 2px);" PostBackUrl="~/UI/Admin/ProductShow.aspx" CssClass="btn btn-outline-success" runat="server" OnClick="Button1_Click" Text="Search" />
        </div>
    </div>
    <div class="btn-group mr-5">
        <button type="button" class="btn btn-success dropdown-toggle m-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="left: 4px; top: 1px; width: 87px; height: calc(1.5em + .75rem + 2px);">
            View
        </button>
        <div class="dropdown-menu">
            <asp:CheckBox ID="ChkCode" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Code" OnCheckedChanged="Code_CheckedChanged" Checked="true" />
            <asp:CheckBox ID="ChkName" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Name" OnCheckedChanged="ChkName_CheckedChanged" Checked="true" />
            <asp:CheckBox ID="ChkPriceImport" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Price Import" OnCheckedChanged="ChkPriceImport_CheckedChanged" Checked="true" />
            <asp:CheckBox ID="ChkPriceSale" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Price Sale" OnCheckedChanged="ChkPriceSale_CheckedChanged" Checked="true" />
            <asp:CheckBox ID="ChkQuantity" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Quantity" OnCheckedChanged="ChkQuantity_CheckedChanged" Checked="true" />
            <asp:CheckBox ID="ChkCategory" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Category" OnCheckedChanged="ChkCategory_CheckedChanged" Checked="true" />
            <asp:CheckBox ID="ChkStatus" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Status" OnCheckedChanged="ChkStatus_CheckedChanged" Checked="true" />
        </div>
        <button type="button" data-toggle="modal" data-target="#myEdit" class="btn btn-success m-2" style="left: 4px; top: 1px; width: 50px; height: calc(1.5em + .75rem + 2px);">
            <a href="AddProduct.aspx" style="color: white;"><i class="fa fa-plus"></i></a>
        </button>

    </div>

    <br />
    <div>
        <asp:GridView ID="GridView1" HeaderStyle-CssClass="thead-light" RowStyle-CssClass="table-light" Width="100%" runat="server" EmptyDataText="Can't found anything" CssClass="m-1 table table-hover" AutoGenerateColumns="False" DataKeyNames="product_id" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:TemplateField HeaderText="Code">
                    <EditItemTemplate>
                        <asp:Label ID="txtCode" runat="server" Text='<%# Eval("product_id") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCode" runat="server" Text='<%# Eval("product_id")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("product_name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("product_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category">

                    <EditItemTemplate>

                        <asp:SqlDataSource ID="SqlDataCategory" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="select * from category"></asp:SqlDataSource>
                        <asp:DropDownList ID="listCate" runat="server" DataSourceID="SqlDataCategory" DataTextField="category_name" DataValueField="cate_id" Width="95px" SelectedValue='<%# getInt(Eval("cate_id")) %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("category_name") %>'></asp:Label>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price Import">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPriceImport" runat="server" Text='<%# Eval("price_import") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPriceImport" runat="server" Text='<%# Eval("price_import") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPrice" runat="server" Text='<%# Eval("price_sale") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price_sale") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("quantity") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <EditItemTemplate>
                        <asp:DropDownList ID="listStatus" runat="server" DataSourceID="SqlDataStatus" DataTextField="status_name" DataValueField="status_id" SelectedValue='<%# getInt(Eval("status_id")) %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataStatus" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT * FROM [Status]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("status_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle CssClass="thead-light" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></HeaderStyle>
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT Product.product_id, Product.product_name, Product.price_import, Product.price_sale, Product.quantity, Category.category_name, Status.status_name, Category.cate_id, Status.status_id FROM Product INNER JOIN Category ON Product.category_id = Category.cate_id INNER JOIN Status ON Product.status_id = Status.status_id"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT Product.product_id, Product.product_name, Product.price_import, Product.price_sale, Product.quantity, Category.category_name, Status.status_name FROM Product INNER JOIN Category ON Product.category_id = Category.cate_id INNER JOIN Status ON Product.status_id = Status.status_id WHERE (Product.product_name LIKE '%' + @product_name2 + '%')">
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBox1" Name="product_name2" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
