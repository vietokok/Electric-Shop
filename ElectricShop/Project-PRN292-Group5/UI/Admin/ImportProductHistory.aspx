<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Admin/Admin1.Master" AutoEventWireup="true" CodeBehind="ImportProductHistory.aspx.cs" Inherits="Project_PRN292_Group5.UI.Admin.ImportProductHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mx-auto" style="width: 200px;">
        <h3><span class="badge badge-info mb-2">History Import</span></h3>
    </div>
    <div class="input-group mb-3">
        <asp:TextBox ID="TextBox1" AutoPostBack="true" runat="server" CssClass="mb-3 form-control" placeholder="Search..." Style="margin-bottom: 0px"></asp:TextBox>
        <div class="input-group-append">
            <asp:Button ID="Button1" Style="height: calc(1.5em + .75rem + 2px);" PostBackUrl="~/UI/Admin/ImportProductHistory.aspx" CssClass="btn btn-outline-success" runat="server" Text="Search" OnClick="Button1_Click" />
        </div>
    </div>
    <div class="row">        
        <div class="btn-group col-md-4">
            <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="left: 4px; top: 1px; width: 87px; height: calc(1.5em + .75rem + 2px);">
                View</button>
            <div class="dropdown-menu">
                <asp:CheckBox ID="ChkCode" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Code" Checked="true" OnCheckedChanged="ChkCode_CheckedChanged" />
                <asp:CheckBox ID="ChkDate" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Name" Checked="true" OnCheckedChanged="ChkDate_CheckedChanged" />
                <asp:CheckBox ID="ChkStaff" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Price Import" Checked="true" OnCheckedChanged="ChkStaff_CheckedChanged" />
                <asp:CheckBox ID="ChkSuplier" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Price Sale" Checked="true" OnCheckedChanged="ChkSuplier_CheckedChanged" />
                <asp:CheckBox ID="ChkTotal" runat="server" CssClass="dropdown-item" AutoPostBack="true" Text="Quantity" Checked="true" OnCheckedChanged="ChkTotal_CheckedChanged" />
            </div>
        </div>       
    </div>


    <br />

    <asp:GridView ID="GridView1" HeaderStyle-CssClass="thead-light" RowStyle-CssClass="table-light" Width="100%" runat="server" EmptyDataText="Can't found anything" CssClass="m-1 table table-hover" AutoGenerateColumns="False" DataKeyNames="id" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True" PageSize="5" OnSelectedIndexChanging="GridView1_SelectedIndexChanging" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField HeaderText="Code">
                <EditItemTemplate>
                    <asp:Label ID="txtCode" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblCode" runat="server" Text='<%# Eval("id")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Import Date">
                <EditItemTemplate>
                    <asp:Calendar ID="editDate" runat="server" SelectedDate='<%# Eval("import_date") %>'></asp:Calendar>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblDate" runat="server" Text='<%# dateFormat(Eval("import_date"))%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Staff">
                <EditItemTemplate>
                    <asp:SqlDataSource ID="SqlDataStaff" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT [staff_name], [staff_id] FROM [Staff]"></asp:SqlDataSource>
                    <asp:DropDownList ID="listStaff" runat="server" DataSourceID="SqlDataStaff" DataTextField="staff_name" DataValueField="staff_id" SelectedValue='<%# getString(Eval("staff_id")) %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblStaff" runat="server" Text='<%# Eval("staff_name")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Suplier">
                <EditItemTemplate>
                    <asp:DropDownList ID="listSuplier" runat="server" DataSourceID="SqlDataSuplier" DataTextField="suplier_name" DataValueField="suplier_id" SelectedValue='<%# getString(Eval("suplier_id")) %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSuplier" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT [suplier_name], [suplier_id] FROM [Suplier]"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSuplier" runat="server" Text='<%# Eval("suplier_name")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total Price">
                <EditItemTemplate>
                    <asp:TextBox ID="txtTotal" runat="server" Text='<%# Eval("total_price") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("total_price")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField SelectText="Detail" ShowSelectButton="True" />
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
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT ImportBill.id, ImportBill.import_date, Staff.staff_name, Suplier.suplier_name, ImportBill.total_price, Suplier.suplier_id, Staff.staff_id FROM Account INNER JOIN ImportBill ON Account.username = ImportBill.staff_id INNER JOIN Staff ON Account.username = Staff.staff_id INNER JOIN Suplier ON ImportBill.suplier_id = Suplier.suplier_id WHERE (Staff.staff_name LIKE '%' + @staff_name + '%') OR (Suplier.suplier_name LIKE '%' + @suplier_name + '%')">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox1" Name="staff_name" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox1" Name="suplier_name" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT ImportBill.id, ImportBill.import_date, Staff.staff_name, Suplier.suplier_name, ImportBill.total_price, Staff.staff_id, Suplier.suplier_id FROM Account INNER JOIN ImportBill ON Account.username = ImportBill.staff_id INNER JOIN Staff ON Account.username = Staff.staff_id INNER JOIN Suplier ON ImportBill.suplier_id = Suplier.suplier_id"></asp:SqlDataSource>


    <asp:Label ID="Label1" runat="server" Text="Detail Import" CssClass="badge badge-danger mb-2"></asp:Label>
    <asp:GridView ID="GridView2" HeaderStyle-CssClass="thead-light" RowStyle-CssClass="table-light" Width="100%" runat="server" EmptyDataText="Can't found anything" CssClass="m-1 table table-hover" AutoGenerateColumns="False" DataKeyNames="id" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True" PageSize="5" OnSelectedIndexChanging="GridView1_SelectedIndexChanging" DataSourceID="SqlDataSource3" OnPageIndexChanging="GridView2_PageIndexChanging">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Import Code" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="product_name" HeaderText="Product Name" SortExpression="product_name" />
            <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
            <asp:BoundField DataField="priceAitem" HeaderText="Price per item" SortExpression="priceAitem" />
            <asp:BoundField DataField="total_price" HeaderText="Total" SortExpression="total_price" />
        </Columns>
        <EditRowStyle BackColor="#7C6F57" />
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle CssClass="thead-light" BackColor="#1C5E55" Font-Bold="True" ForeColor="White"></HeaderStyle>
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT ImportBill.id, Product.product_name, Detail_ImportBill.quantity, Detail_ImportBill.priceAitem, Detail_ImportBill.total_price FROM Detail_ImportBill INNER JOIN ImportBill ON Detail_ImportBill.import_id = ImportBill.id INNER JOIN Product ON Detail_ImportBill.product_id = Product.product_id where import_id =@import_id">
        <SelectParameters>
            <asp:SessionParameter Name="import_id" SessionField="datakeys" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
