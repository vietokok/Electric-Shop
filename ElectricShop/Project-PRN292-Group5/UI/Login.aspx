<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Project_PRN292_Group5.UI.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Login</title>
    <meta name="description" content="Electric Shop Online" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Assets/Admin/Framework/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css' />
    <link href="../../Assets/Admin/Framework/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Assets/Admin/Css/style.css" rel="stylesheet" />
</head>
<body class="bg-dark">
    <div class="sufee-login d-flex align-content-center flex-wrap">
        <div class="container">
            <div class="login-content">
                <div class="login-logo">
                    <a href="index.html">
                        <h2>MK Shop</h2>
                    </a>
                </div>
                <div class="login-form">
                    <form id="form1" runat="server">
                        <div class="form-group">
                            <label>Username</label>
                            <asp:TextBox ID="TextBox1" class="form-control" placeholder="User Name" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <asp:TextBox ID="TextBox2" class="form-control" type="password" placeholder="Password" runat="server"></asp:TextBox>
                        </div>
                        <div class="checkbox">
                            <label>
                                <asp:CheckBox ID="checkBox1" runat="server" />Remember Me                           
                            </label>
                        </div>
                        <asp:Button ID="Button1" class="btn btn-success btn-flat m-b-30 m-t-30" runat="server" Text="Quản Lý" Width="235px" OnClick="Button1_Click" />
                        <asp:Button ID="Button2" class="btn btn-info btn-flat m-b-30 m-t-30" runat="server" Text="Bán Hàng" Width="235px" OnClick="Button2_Click" />
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="../../Assets/Admin/Framework/jquery-3.4.1.min.js"></script>
    <script src="../../Assets/Admin/Framework/popper.min.js"></script>
    <script src="../../Assets/Admin/Framework/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
