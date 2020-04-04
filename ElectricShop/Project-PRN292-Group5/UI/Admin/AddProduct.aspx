<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Admin/Admin1.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="Project_PRN292_Group5.UI.Admin.AddProduct"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <asp:Button ID="Button2" runat="server" Text="View Product" class="btn btn-outline-info col-md-6" OnClick="Button2_Click" />
        <asp:Button ID="Button3" runat="server" Text="Import Product History" class="btn btn-outline-warning col-md-6 text-dark" OnClick="Button3_Click" />
    </div>
    <div class="form-group">
        <label>
            Name Product</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text="Product Name"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid format" ForeColor="Red" ValidationExpression="[a-zA-Z0-9 ]{1,100}" ControlToValidate="txtName"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Enter Product" ForeColor="Red"></asp:RequiredFieldValidator>
    </div>
    <div class="form-group">
        <label>Price</label>
        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" Text="100"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Please enter price import is a double number!!" ForeColor="Red" ValidationExpression="[\d]+.[\d]+|[\d]{1,}" ControlToValidate="txtPrice"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPrice" ErrorMessage="Enter Price" ForeColor="Red"></asp:RequiredFieldValidator>
    </div>
    <div class="form-row">
        <div class="form-group col-md-6">
            <label>Category</label>
            <asp:DropDownList ID="listCate" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="category_name" DataValueField="cate_id"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT * FROM [Category]"></asp:SqlDataSource>
        </div>
        <div class="form-group col-md-6">
            <label>Status</label>
            <asp:DropDownList ID="listStatus" runat="server" CssClass="form-control" DataSourceID="SqlDataSource2" DataTextField="status_name" DataValueField="status_id"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:myConnection %>" SelectCommand="SELECT * FROM [Status]"></asp:SqlDataSource>
        </div>
    </div>

    <asp:Button ID="Button1" runat="server" Text="Add new product" class="btn btn-success" OnClick="Button1_Click" />
</asp:Content>
