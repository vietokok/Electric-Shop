<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="StaffManagement.aspx.cs" Inherits="Project_PRN292_Group5.UI.Admin.StaffManagement" %>
<%@ Import Namespace="Project_PRN292_Group5.Entity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%List<Staff> listStaff = (List<Staff>)Session["listStaff"]; %>
    <%List<Account> listAccount = (List<Account>)Session["listAccount"]; %>
    <%string er = (string)Session["er"]; %>
    <%if (er != null)
        { %>
    <h3><%=er %></h3>
    <%} %>
    <table class="table table-hover">
        <thead class="thead-light">
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Tên Nhân Viên</th>
                <th scope="col">Ngày Sinh</th>
                <th scope="col">Giới Tính</th>
                <th scope="col">Địa Chỉ</th>
                <th scope="col">Ghi chú</th>
            </tr>
        </thead>
        <tbody>
            <%for (int i = 0; i < listStaff.Count; i++)
                { %>
            <tr>
                <th scope="row"><%=listStaff[i].ID%></th>
                <td><%=listStaff[i].Name%></td>
                <td><%=listStaff[i].Date%></td>
                <td><%=listStaff[i].Gender%></td>
                <td><%=listStaff[i].Address%></td>
                <td><%=listStaff[i].Note%></td>
                <td>
                    <form action="StaffManagement.aspx" method="post">
                        <input type="hidden" name="delete" value="deleteStaff" />
                        <input type="hidden" name="id" value="<%=listStaff[i].ID%>" />

                        <button class="btn btn-default" type="submit"><i class="fa fa-trash"></i></button>
                    </form>
                </td>
                <td>
                    <div class="row margin-row">
                        <div class="col-md-5">
                            <%--button edit staff--%>
                            <div class="addCustomer">

                                <button class="btn btn-success" type="button" data-toggle="modal" data-target="#editCus<%=listStaff[i].ID%>"><i class="fa fa-edit"></i>&nbsp;Sửa</button>

                                <div class="modal fade" id="editCus<%=listStaff[i].ID%>" tabindex="-1" role="dialog">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel1">Sửa Nhân Viên</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form id="frm-editStaff<%=i%>" action="StaffManagement.aspx" method="post">
                                                    <input type="hidden" name="editStaff" value="E_staff">
                                                    <input type="hidden" name="ID<%=i%>" value="<%=listStaff[i].ID%>" />
                                                    <input type="hidden" name="index" value="<%=i%>" />
                                                    <div class="form-group">
                                                        <label class="col-form-label">ID</label>
                                                        <input type="text" class="form-control" id="edit-id<%=i%>" name="edit_id<%=i%>" value="<%=listStaff[i].ID %>" disabled />
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-form-label">Tên nhân viên</label>
                                                        <input type="text" class="form-control" id="name<%=i%>" name="name<%=i%>" value="<%=listStaff[i].Name %>" />

                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-form-label">Ngày sinh </label>
                                                        <input type="text" class="form-control" id="date<%=i%>" name="date<%=i%>" value="<%=listStaff[i].Date %>" />

                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-form-label">Giới tính</label>
                                                        <input type="text" class="form-control" id="gender<%=i%>" name="gender<%=i%>" value="<%=listStaff[i].Gender %>" />

                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-form-label">Địa Chỉ</label>
                                                        <input type="text" class="form-control" id="adress<%=i%>" name="adress<%=i%>" value="<%=listStaff[i].Address %>" />

                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-form-label">Ghi Chú</label>
                                                        <input type="text" class="form-control" id="note<%=i%>" name="note<%=i%>" value="<%=listStaff[i].Note %>"/>

                                                    </div>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                                <button type="button" class="btn btn-primary" onclick="checkInput1('<%=i%>')">Sửa</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--end button add customer--%>
                        </div>
                    </div>
                </td>
            </tr>
            <%} %>
        </tbody>
    </table>
    <div class="row margin-row">
        <div class="col-md-5">
            <%--button add staff--%>
            <div class="addCustomer">

                <button class="btn btn-info" type="button" data-toggle="modal" data-target="#addCus"><i class="fa fa-plus"></i>&nbsp;Thêm Nhân Viên</button>
                <div class="modal fade" id="addCus" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Thêm Nhân Viên</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="frm-addStaff" action="StaffManagement.aspx" method="post">
                                    <input type="hidden" name="addStaff" value="staff">
                                    <div class="form-group">
                                        <label class="col-form-label">ID</label>
                                        <select name="id">                                            
                                            <option value="admin">Admin</option>
                                            <option value="staff">Staff</option>                                            
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Tài Khoản</label>
                                        <input type="text" class="form-control" id="username" name="username" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Mật Khẩu</label>
                                        <input type="text" class="form-control" id="pass" name="pass" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Email</label>
                                        <input type="text" class="form-control" id="email" name="email" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Tên nhân viên</label>
                                        <input type="text" class="form-control" id="cus-name" name="name" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Ngày sinh </label>
                                        <input type="date" class="form-control" id="cus-date" name="date" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Giới tính</label>
                                        <input type="text" class="form-control" id="cus-gender" name="gender" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Địa Chỉ</label>
                                        <input type="text" class="form-control" id="cus-adress" name="adress" />
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Ghi Chú</label>
                                        <input type="text" class="form-control" id="cus-note" name="note" />
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                <button type="button" class="btn btn-primary" onclick="checkInput()">Tạo</button>
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
