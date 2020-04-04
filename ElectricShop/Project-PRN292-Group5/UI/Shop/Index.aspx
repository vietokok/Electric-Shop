<%@ Page Title="" Language="C#" MasterPageFile="~/UI/Shop/Shop.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Project_PRN292_Group5.UI.Shop.Index" %>

<%@ Import Namespace="Project_PRN292_Group5.Entity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%  List<Product> listProducts = (List<Product>)Session["listProducts"];
        string key = (string)Session["key"];
        string searchCus = (string)Session["searchCus"];
        ExportBill order = (ExportBill)Session["cart"];
        List<Customer> listCustomer = (List<Customer>)Session["listCustomer"];
        Session["check"] = "true";
        string nowDate = DateTime.Now.ToString("dd/MM/yyyy");
        string nowHour = DateTime.Now.ToString("HH:mm");
        int totalPage = (int)Session["totalPage"];
        int pageCurrent = (int)Session["pageCurrent"];%>
    <div class="main-panel">
        <div class="left-panel">
            <%--cart--%>
            <div class="flex-left-panel">
                <div class="cart">
                    <div class="search-product-area">
                        <div class="search-panel">                          
                            <div class="input-group">
                                <form id="frm-search" action="Index.aspx" method="post">
                                    <input class="form-control" type="text" name="key" value="<%=key!=null?key:"" %>" placeholder="Tìm sản phẩm" />
                                </form>
                            </div>
                        </div>
                        <div>
                            <button class="btn btn-default button-s" onclick="document.getElementById('frm-search').submit()"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                    <%if (order != null)
                        {
                    %>
                    <table class="table table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col"></th>
                                <th scope="col">Mã sản phẩm</th>
                                <th scope="col">Tên sản phẩm</th>
                                <th scope="col">Giá sản phẩm</th>
                                <th scope="col">Số lượng</th>
                                <th scope="col">Giảm giá</th>
                                <th scope="col">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < order.Lines.Count; i++)
                                {
                                    DetailExportBill detail = order.Lines[i];
                            %>
                            <tr>
                                <td>
                                    <form action="Index.aspx" method="post">
                                        <input type="hidden" name="delete" value="deleteCart" />
                                        <input type="hidden" name="id" value="<%=detail.Product.Id %>" />
                                        <button class="btn btn-default" type="submit"><i class="fa fa-trash"></i></button>
                                    </form>
                                </td>
                                <td><%=detail.Product.Id%></td>
                                <td><%=detail.Product.Name %></td>
                                <td><%=detail.ToTalPrice %></td>
                                <td><%=detail.Quantity %></td>
                                <td>
                                    <form id="discount<%=i %>" action="Index.aspx" method="post">
                                        <input type="hidden" name="frmDiscount" value="<%=i %>" />
                                        <select name="valueDiscount" onchange="document.getElementById('discount<%=i %>').submit()">
                                            <%int discount = Convert.ToInt32((detail.Discount / detail.ToTalPrice * 100) / detail.Quantity);
                                                for (int j = 0; j < 100; j += 10)
                                                {
                                            %>
                                            <option value="<%=j %>" <%=discount==j?"selected":"" %>><%=(j + "%")%></option>
                                            <%} %>
                                        </select>
                                    </form>
                                </td>
                                <th scope="row"><%=detail.ToTalPrice*detail.Quantity - detail.Discount %></th>
                            </tr>
                            <%} %>
                        </tbody>
                    </table>
                    <%} %>
                </div>
                <%--end cart--%>
                <%--show product--%>
                <div class="items">
                    <%--search product--%>
                    <div class="search-items">
                        <div class="row search-paging" style="display: flex">
                            <div class="col-md-6 paging">
                                <%for (int page = 1; page <= totalPage; page++)
                                    {%>
                                <%if (pageCurrent == page)
                                    {%>
                                <p class="page-current"><%=page %></p>
                                <%}%>
                                <%if (pageCurrent != page)
                                    {%>
                                <a class="mx-2" href="Index.aspx?pageChoose=<%=page %>"><%=page %></a>
                                <%}%>

                                <% } %>
                            </div>
                        </div>
                    </div>
                    <%--end product--%>
                    <%--table product--%>
                    <div class="show-items">
                        <%if (listProducts != null)
                            {
                        %>
                        <%foreach (var product in listProducts)
                            {
                        %>

                        <div class="product-show">
                            <form id="<%=product.Id %>" action="Index.aspx" method="post">
                                <input type="hidden" name="productId" value="<%=product.Id %>" />
                                <div style="position: relative" onclick="document.getElementById(<%=product.Id %>).submit()">
                                    <img class="img-product" src="<%=product.Image %>" /><br />
                                    <p><%=product.Name %></p>
                                    <div class="price-a-item">
                                        <div><%=product.PriceSale %></div>
                                    </div>

                                </div>
                            </form>
                        </div>
                        <%}%>
                        <%} %>
                        <div class="clear"></div>
                    </div>
                    <%--end table product--%>
                </div>
                <%--end show product--%>
            </div>
        </div>
        <div class="right-panel">
            <div class="container right-content">
                <div class="row margin-row">
                    <div class="col-md-7">
                        <div class="showCus">
                            <select class="select-cus" id="select-cusname" name="selectCus">
                                <%if (listCustomer == null || listCustomer.Count < 1)
                                    {
                                %>
                                <option value="-1">Không tìm thấy dữ liệu</option>
                                <%}
                                    else
                                    {
                                %>
                                <%foreach (var cus in listCustomer)
                                    {
                                %>
                                <option value="<%=cus.ID %>"><%=cus.Name %></option>
                                <%} %>
                                <% }%>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 fix-center">
                        <div class="time-now">
                            <%=nowDate %>
                        </div>
                    </div>
                    <div class="col-md-2 fix-center">
                        <div class="time-now">
                            <%=nowHour %>
                        </div>
                    </div>
                </div>

                <div class="row margin-row">
                    <div class="col-md-7 fix-center">
                        <div class="search-cus">
                            <form id="frm-search-cus" action="Index.aspx" method="post">
                                <input type="hidden" value="cus" name="searchCus" />
                                <input placeholder="Tìm Khách Hàng" class="input-cus-search" type="text" name="partCusName" value="<%=searchCus!=null?searchCus:"" %>" />
                            </form>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <%--button add customer--%>
                        <div class="addCustomer">
                            <button class="btn btn-default" type="submit" value="Search" onclick="document.getElementById('frm-search-cus').submit()"><i class="fa fa-search"></i></button>
                            <button class="btn btn-info" type="button" data-toggle="modal" data-target="#addCus"><i class="fa fa-plus"></i></button>
                            <div class="modal fade" id="addCus" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">Thêm khách hàng</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form id="frm-addCus" action="Index.aspx" method="post">
                                                <div class="form-group">
                                                    <label class="col-form-label">Tên khách hàng</label>
                                                    <input type="text" class="form-control" id="cus-name" name="name" />
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-form-label">Địa chỉ</label>
                                                    <input type="text" class="form-control" id="cus-address" name="address" />
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
                                            <button type="button" class="btn btn-primary" onclick="checkInput()">Tạo</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--end button add customer--%>
                    </div>
                </div>

                <div class="row margin-row">
                    <div class="col-md-12 fix-center title-export">
                        <div>Hóa đơn</div>
                    </div>
                </div>

                <div class="row margin-row">
                    <div class="col-md-6 fix-center">Tổng tiền hàng</div>
                    <div class="col-md-6 fix-center">
                        <%float total = 0; %>
                        <%if (order != null)
                            {
                                for (int k = 0; k < order.Lines.Count; k++)
                                {
                                    DetailExportBill detail = order.Lines[k];
                                    total += detail.ToTalPrice * detail.Quantity;
                                }
                            }
                        %>
                        <%=total %>
                    </div>
                </div>

                <div class="row margin-row">
                    <div class="col-md-6 fix-center">Giảm giá</div>
                    <div class="col-md-6 fix-center">
                        <%float totalDiscount = 0;%>
                        <%if (order != null)
                            {
                                for (int index = 0; index < order.Lines.Count; index++)
                                {
                                    DetailExportBill detail = order.Lines[index];
                                    totalDiscount += detail.Discount;
                                }
                            }%>
                        <%=totalDiscount %>
                    </div>
                </div>

                <div class="row margin-row">
                    <div class="col-md-6 fix-center">Khách cần trả</div>
                    <div class="col-md-6 fix-center"><%=total - totalDiscount%></div>
                </div>

                <div class="row margin-row">
                    <div class="col-md-12 clear-line fix-center">
                        <input id="note" type="text" name="note-export-bill" placeholder="Ghi Chú" style="width: 100%" />
                    </div>
                </div>
                <div class="row margin-row">
                    <div class="col-md-12 fix-center">
                        <input id="count-order" type="hidden" value='<%=Session["cart"]!=null?order.Lines.Count:-1 %>' />
                        <form id="frm-checkout" action="Index.aspx" method="post">
                            <input type="hidden" name="checkout" value="ok" />
                            <input id="cusname" type="hidden" value="cusname" name="cusName" />
                            <input id="note-order" type="hidden" value="note" name="note" />
                        </form>
                        <button onclick="checkOut()" class="btn btn-success button-checkout font-change">Thanh toán</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../../Assets/Shop/js/index.js"></script>
</asp:Content>

