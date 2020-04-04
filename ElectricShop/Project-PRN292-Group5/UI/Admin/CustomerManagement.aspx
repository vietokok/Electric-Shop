<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="CustomerManagement.aspx.cs" Inherits="Project_PRN292_Group5.UI.Admin.CustomerManagement" %>

<%@ Import Namespace="Project_PRN292_Group5.Entity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%List<Customer> listCus = (List<Customer>)Session["listCustomer"]; %>

    <table class="table table-hover">
        <thead class="thead-light">
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Tên Khách Hàng</th>
                <th scope="col">Địa chỉ</th>
                <th scope="col">Số điện thoại</th>
                <th scope="col">Ghi chú</th>
            </tr>
        </thead>
        <tbody>
            <%for (int i = 0; i < listCus.Count; i++)
                { %>

            <tr>
                <th scope="row"><%=listCus[i].ID%></th>
                <td><%=listCus[i].Name%></td>
                <td><%=listCus[i].Address%></td>
                <td><%=listCus[i].Phone%></td>
                <td><%=listCus[i].Note%></td>
                <td>
                    <form action="CustomerManagement.aspx" method="post">
                        <input type="hidden" name="deleteCus" value="deleteCus" />
                        <input type="hidden" name="id" value="<%=listCus[i].ID%>" />

                        <button class="btn btn-default" type="submit"><i class="fa fa-trash"></i></button>
                    </form>
                </td>
            </tr>
            <%} %>
        </tbody>
    </table>
    <div class="row margin-row">
        <div class="col-md-5">
            <%--button add customer--%>
            <div class="addCustomer">
                <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#addCus1"><i class="fa fa-plus"></i>&nbsp;Thêm Khách Hàng</button>
                <div class="modal fade" id="addCus1" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Thêm Khách Hàng</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="frm-addCus" action="CustomerManagement.aspx" method="post">
                                    <input type="hidden" name="addCus" value="customer">


                                    <div class="form-group">
                                        <label class="col-form-label">Tên khách hàng</label>
                                        <input type="text" class="form-control" id="cus-name" name="name" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Địa chỉ </label>
                                        <input type="text" class="form-control" id="cus-adress" name="address" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Số điện thoại</label>
                                        <input type="text" class="form-control" id="cus-phone" name="phone" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Ghi chú</label>
                                        <input type="text" class="form-control" id="cus-note" name="note" />
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                <button type="button" class="btn btn-primary" onclick="checkInput2()">Tạo</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--end button add customer--%>
        </div>
    </div>
    <script src="../../Assets/Admin/js/Staff.js"></script>
</asp:Content>
