<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Admin/Admin1.Master" AutoEventWireup="true" CodeBehind="ImportProduct.aspx.cs" Inherits="Project_PRN292_Group5.UI.Admin.ImportProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-lg-6">
            <h3><span class="badge badge-pill mb-2">PRODUCTS</span></h3>
            <asp:GridView ID="GridView1" HeaderStyle-CssClass="thead-light" RowStyle-CssClass="table-light" Width="100%" runat="server" EmptyDataText="Can't found anything" CssClass="m-1 table table-hover" AutoGenerateColumns="False" DataKeyNames="product_id" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True" DataSourceID="SqlDataSource1" OnSelectedIndexChanging="GridView1_SelectedIndexChanging" OnPageIndexChanging="GridView1_PageIndexChanging">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="product_id" HeaderText="Product Code" InsertVisible="False" ReadOnly="True" SortExpression="product_id" />
                    <asp:BoundField DataField="product_name" HeaderText="Product Name" SortExpression="product_name" />
                    <asp:BoundField DataField="category_name" HeaderText="Category" SortExpression="category_name" />
                    <asp:BoundField DataField="price_import" HeaderText="Price Import" SortExpression="price_import" />
                    <asp:BoundField DataField="price_sale" HeaderText="Price Sale" SortExpression="price_sale" />
                    <asp:CommandField ShowSelectButton="True" />
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT Category.*, Product.* FROM Category INNER JOIN Product ON Category.cate_id = Product.category_id"></asp:SqlDataSource>

        </div>
        <div class="col-lg-6">
            <h3><span class="badge badge-info mb-2">List Import</span><asp:Label ID="Label1" runat="server" ForeColor="Red" Text="Please choose product to import"></asp:Label>
            </h3>

            <asp:GridView ID="GridView2" HeaderStyle-CssClass="thead-light" EmptyDataText="No product is already import" RowStyle-CssClass="table-light" Width="100%" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnRowDeleting="GridView2_RowDeleting" PageSize="5" ShowFooter="True">
                <Columns>
                    <asp:BoundField DataField="product_id" HeaderText="Code" />
                    <asp:BoundField DataField="product_name" HeaderText="Name" />
                    <asp:BoundField DataField="price_sale" HeaderText="Price" />
                    <asp:TemplateField HeaderText="Price Import">
                        <ItemTemplate>
                            <asp:TextBox ID="txtPriceImport" CssClass="form-control" runat="server" Text='<%# Eval("price_import") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQuantity" CssClass="form-control" runat="server" Text='<%# Eval("quantity") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="total" HeaderText="Total Import Price" />
                    <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-danger" HeaderText="Delete" ShowDeleteButton="True" ShowHeader="True">
                        <ControlStyle CssClass="btn btn-danger"></ControlStyle>
                    </asp:CommandField>
                </Columns>
                <FooterStyle BackColor="#FFFF99" ForeColor="#333333" />
                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#487575" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#275353" />
            </asp:GridView>
            <asp:Button ID="Button1" CssClass="btn btn-outline-info m-2" PostBackUrl="~/UI/Admin/ImportProduct.aspx" runat="server" Text="Refresh" OnClick="Button1_Click" />
            <div class="row">
                <div class="form-group col-md-6">
                    <label class="form-control">Staff</label>
                    <asp:DropDownList ID="listStaff" CssClass="form-control" runat="server" DataSourceID="SqlDataSource2" DataTextField="staff_name" DataValueField="staff_id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT * FROM [Staff]"></asp:SqlDataSource>
                </div>
                <div class="form-group col-md-6">
                    <label class="form-control">Suplier</label>
                    <asp:DropDownList ID="listSuplier" CssClass="form-control" runat="server" DataSourceID="SqlDataSource3" DataTextField="suplier_name" DataValueField="suplier_id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT * FROM [Suplier]"></asp:SqlDataSource>
                </div>
            </div>
            <div class="text-center">
                <asp:Button ID="Button2" CssClass="btn btn-success m-5" runat="server" Text="Import" Height="59px" OnClick="Button2_Click" Width="250px" />
            </div>

        </div>
    </div>
</asp:Content>
