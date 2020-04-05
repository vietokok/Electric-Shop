<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderManagement.aspx.cs" Inherits="Project_PRN292_Group5.UI.Admin.OrderManagement" %>

<%@ Import Namespace="Project_PRN292_Group5.Entity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%List<ExportBill> listBill = (List<ExportBill>)Session["listOrder"];
        ExportBill ex = (ExportBill)Session["detailInfo"];
        List<DetailExportBill> lDe = (List<DetailExportBill>)Session["detailOrder"];
        float total = 0;
        Session["check"] = "true";
        string key = (string)Session["key"];
        int totalPage = (int)Session["totalPage"];
        int pageCurrent = (int)Session["pageCurrent"];
        string check = (string)Session["check"];
    %>
    <style>
    </style>
    <div>
        <select id="123ch" onchange="changedType(this)" class="mb-4">
            <option value="xname">Thống kê theo tên</option>
            <option value="xdate">Thống kê theo ngày</option>
        </select>
    </div>
    <divs>
        <form action="OrderManagement.aspx" method="post">
            <div style="display: inline-block">
                <div class="" id="customerName">
                    <input class="search-product" type="text" name="key" placeholder="Tìm tên khách hàng" />
                </div>
                <div id="date" class="hidden">
                    <input type="date" name="begin" />
                    <input type="date" name="end" />
                </div>
            </div>
            <div  style="display: inline-block">
                <button  class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
            </div>
        </form>
    </divs>
    <%-- hien thi thong tin chung hoa don --%>
    <div>
        <table class="table table-hover">
            <thead class="thead-light">
                <tr>
                    <th scope="col">Mã Hóa Đơn</th>
                    <th scope="col">Thời Gian </th>
                    <th scope="col">Khách Hàng</th>
                    <th scope="col">Tổng Tiền</th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
                <%for (int i = 0; i < listBill.Count; i++)
                    {
                %>
                <tr>
                    <td><%=listBill[i].ID %></td>
                    <td><%=listBill[i].Date %></td>
                    <td><%=listBill[i].Customer.Name %></td>
                    <td><%=listBill[i].TotalPrice1 %></td>
                    <td>
                        <form action="OrderManagement.aspx" method="post">
                            <input type="hidden" name="detail" value="detailOrder" />
                            <input type="hidden" name="id" value="<%=listBill[i].ID %>" />
                            <p>
                                <button class="btn btn-outline-dark" type="submit" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                                    Chi Tiết                               
                               
                                </button>
                            </p>
                        </form>
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
    </div>
    <%--search product--%>
    <nav style="margin-left: 500px">
        <ul class="pagination pagination-sm">
            <li class="page-item disabled">
                <%for (int page = 1; page <= totalPage; page++)
                    {%>
                <%if (pageCurrent == page)
                    {%>
                <a class="page-current"><%=page %></a>
                <%}%>
            </li>
            <%if (pageCurrent != page)
                {%>
            <li class="page-item"><a class="page-link " href="OrderManagement.aspx?pageChoose=<%=page %>"><%=page %></a></li>
            <%}%>
            <% } %>
        </ul>
    </nav>

    <%-- chi tiet hoa don --%>
    <%if (ex != null)
        {
    %>
    <div id="collapseExample">
        <div class="card card-body">
            <div class="col mb-4">
                <div class="row">
                    <div class="col-sm-12  col-md-4">
                        Mã Hóa Đơn: <%=ex.ID %>
                        <br>
                        Thời Gian:  <%=ex.Date %>
                        <br>
                        Khách Hàng:  <%=ex.Customer.Name %>
                        <br>
                        Bảng Giá:  Bảng giá chung
                   
                   
                    </div>
                    <div class="col-sm-12 col-md-4 ">
                        Trạng Thái:  Hoàn thành
       
                       

                        <br>
                        Chi Nhánh:  Chi nhánh trung tâm
       
                       

                        <br>
                        Người Bán:  <%=ex.Staff.Name %>
                        <br>
                        Kênh Bán:  Bán trực tiếp
                   
                   
                    </div>
                    <div class="col-sm-12 col-md-4 ">
                        <div class="form-group">
                            <textarea class="form-control" rows="3" cols="8"><%=ex.Note %></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <table class="table table-hover">
                <thead class="table-success">
                    <tr>
                        <th scope="col">Mã Hàng</th>
                        <th scope="col">Tên Hàng </th>
                        <th scope="col">Số Lượng</th>
                        <th scope="col">Đơn Giá</th>
                        <th scope="col">Giảm Giá</th>
                        <th scope="col">Thành Tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 0; i < lDe.Count; i++)
                        {
                    %>
                    <tr>
                        <td><%=lDe[i].ExportBill.ID %></td>
                        <td><%=lDe[i].Product.Name %></td>
                        <td><%=lDe[i].Quantity %></td>
                        <td><%=lDe[i].Product.PriceSale %></td>
                        <td><%=lDe[i].Discount %></td>
                        <td><%=lDe[i].ToTalPrice %></td>
                        <input type="hidden" <%=total += lDe[i].ToTalPrice%> />
                    </tr>

                    <%} %>
                    <tr>
                        <td colspan="4"></td>
                        <td><b>TỔNG TIỀN</b></td>
                        <td><%=total %></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <%} %>

    <script>
        // Hàm xử lý khi thẻ select thay đổi giá trị được chọn
        // obj là tham số truyền vào và cũng chính là thẻ select

        function changedType(obj) {


            var value = obj.value;

            if (value === 'xname') {
                var xremove = document.getElementById("customerName");
                var xadd = document.getElementById('date');
                xadd.classList.add("hidden");
                xremove.classList.remove("hidden");
            }
            else if (value === 'xdate') {
                var xremove = document.getElementById("date");
                var xadd = document.getElementById('customerName');
                xadd.classList.add("hidden");
                xremove.classList.remove("hidden");
            }
        }

    </script>
</asp:Content>
