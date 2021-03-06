USE [master]
GO
/****** Object:  Database [ElectricShop]    Script Date: 3/25/2020 4:23:17 PM ******/
CREATE DATABASE [ElectricShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ElectricShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ElectricShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ElectricShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ElectricShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ElectricShop] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ElectricShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ElectricShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ElectricShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ElectricShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ElectricShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ElectricShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [ElectricShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ElectricShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ElectricShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ElectricShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ElectricShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ElectricShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ElectricShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ElectricShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ElectricShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ElectricShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ElectricShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ElectricShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ElectricShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ElectricShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ElectricShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ElectricShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ElectricShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ElectricShop] SET RECOVERY FULL 
GO
ALTER DATABASE [ElectricShop] SET  MULTI_USER 
GO
ALTER DATABASE [ElectricShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ElectricShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ElectricShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ElectricShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ElectricShop] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ElectricShop', N'ON'
GO
ALTER DATABASE [ElectricShop] SET QUERY_STORE = OFF
GO
USE [ElectricShop]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[email] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[cate_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[cate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_name] [nvarchar](50) NULL,
	[state] [nvarchar](max) NULL,
	[phone] [nvarchar](50) NULL,
	[note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detail_ExportBill]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail_ExportBill](
	[export_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [float] NULL,
	[total_price] [float] NULL,
	[discount] [float] NULL,
 CONSTRAINT [PK_Detail_ExportBill] PRIMARY KEY CLUSTERED 
(
	[export_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detail_ImportBill]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail_ImportBill](
	[import_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [float] NULL,
	[priceAitem] [float] NULL,
	[total_price] [float] NULL,
 CONSTRAINT [PK_Detail_ImportBill] PRIMARY KEY CLUSTERED 
(
	[import_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExportBill]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExportBill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[export_date] [datetime] NULL,
	[staff_id] [nvarchar](50) NULL,
	[customer_id] [int] NULL,
	[total_price] [float] NULL,
	[note] [nvarchar](max) NULL,
 CONSTRAINT [PK_ExportBill] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportBill]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportBill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[import_date] [datetime] NULL,
	[staff_id] [nvarchar](50) NULL,
	[suplier_id] [int] NULL,
	[total_price] [float] NULL,
 CONSTRAINT [PK_Import Bill] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](50) NULL,
	[price_import] [float] NULL,
	[price_sale] [float] NULL,
	[quantity] [float] NULL,
	[category_id] [int] NULL,
	[image] [nvarchar](50) NULL,
	[status_id] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[staff_id] [nvarchar](50) NOT NULL,
	[staff_name] [nvarchar](50) NULL,
	[dateOfBirth] [date] NULL,
	[gender] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[note] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[status_id] [int] IDENTITY(1,1) NOT NULL,
	[status_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suplier]    Script Date: 3/25/2020 4:23:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suplier](
	[suplier_id] [int] IDENTITY(1,1) NOT NULL,
	[suplier_name] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
 CONSTRAINT [PK_Suplier] PRIMARY KEY CLUSTERED 
(
	[suplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([username], [password], [type], [email]) VALUES (N'admin', N'123456', N'1', N'admin@gmail.com')
INSERT [dbo].[Account] ([username], [password], [type], [email]) VALUES (N'hoang', N'123456', N'1', N'hoang@gmail.com')
INSERT [dbo].[Account] ([username], [password], [type], [email]) VALUES (N'kien', N'123456', N'1', N'kien@gmail.com')
INSERT [dbo].[Account] ([username], [password], [type], [email]) VALUES (N'phong', N'123456', N'1', N'phong@gmail.com')
INSERT [dbo].[Account] ([username], [password], [type], [email]) VALUES (N'staff', N'staff', N'0', N'staff@gmail.com')
INSERT [dbo].[Account] ([username], [password], [type], [email]) VALUES (N'tuan', N'123456', N'1', N'tuan@gmail.com')
INSERT [dbo].[Account] ([username], [password], [type], [email]) VALUES (N'viet', N'123456', N'1', N'viet123@gmail.com')
INSERT [dbo].[Account] ([username], [password], [type], [email]) VALUES (N'yasuo', N'123456', N'0', N'yasuo@gmail.com')
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([cate_id], [category_name]) VALUES (1, N'Laptop')
INSERT [dbo].[Category] ([cate_id], [category_name]) VALUES (2, N'Tivi')
INSERT [dbo].[Category] ([cate_id], [category_name]) VALUES (3, N'Tablet')
INSERT [dbo].[Category] ([cate_id], [category_name]) VALUES (4, N'Phone')
INSERT [dbo].[Category] ([cate_id], [category_name]) VALUES (5, N'Earphones')
INSERT [dbo].[Category] ([cate_id], [category_name]) VALUES (6, N'Camera')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([customer_id], [customer_name], [state], [phone], [note]) VALUES (1, N'Võ Khắc Việt', N'Hà Nội', N'0938434254', N'none')
INSERT [dbo].[Customer] ([customer_id], [customer_name], [state], [phone], [note]) VALUES (2, N'David Moyes', N'HCM', N'0932454567', N'KHTN')
INSERT [dbo].[Customer] ([customer_id], [customer_name], [state], [phone], [note]) VALUES (3, N'Đỗ Trọng Anh Tuấn', N'Hải Phòng', N'0917463234', N'none')
INSERT [dbo].[Customer] ([customer_id], [customer_name], [state], [phone], [note]) VALUES (4, N'Nguyễn Mạnh Hoàng', N'Hà Nội', N'0989786743', N'none')
INSERT [dbo].[Customer] ([customer_id], [customer_name], [state], [phone], [note]) VALUES (5, N'Cristiano Ronaldo', N'Portugal', N'0918233311', N'none')
INSERT [dbo].[Customer] ([customer_id], [customer_name], [state], [phone], [note]) VALUES (6, N'Bá Công Phong', N'Hà Nội', N'0956475865', N'none')
INSERT [dbo].[Customer] ([customer_id], [customer_name], [state], [phone], [note]) VALUES (7, N'Nguyễn Mạnh Kiên', N'Đà Nẵng', N'0943526112', N'KHTN')
SET IDENTITY_INSERT [dbo].[Customer] OFF
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (1, 1, 2, 1500, 300)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (1, 2, 2, 1350, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (1, 3, 1, 3000, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (2, 4, 1, 9000, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (2, 5, 1, 900, 180)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (2, 6, 1, 6000, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (2, 11, 4, 9000, 7200)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (2, 12, 1, 900, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (3, 9, 4, 8000, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (3, 10, 2, 3000, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (4, 6, 3, 6000, 3600)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (4, 7, 4, 3500, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (4, 8, 1, 10000, 5000)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (5, 1, 1, 1500, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (5, 2, 1, 1350, 270)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (5, 3, 4, 3000, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (5, 4, 1, 9000, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (5, 6, 1, 6000, 0)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (5, 8, 1, 10000, 2000)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (6, 4, 5, 9000, 13500)
INSERT [dbo].[Detail_ExportBill] ([export_id], [product_id], [quantity], [total_price], [discount]) VALUES (7, 5, 3, 900, 0)
INSERT [dbo].[Detail_ImportBill] ([import_id], [product_id], [quantity], [priceAitem], [total_price]) VALUES (2, 1, 15, 200, 3000)
INSERT [dbo].[Detail_ImportBill] ([import_id], [product_id], [quantity], [priceAitem], [total_price]) VALUES (3, 2, 14, 300, 4200)
SET IDENTITY_INSERT [dbo].[ExportBill] ON 

INSERT [dbo].[ExportBill] ([id], [export_date], [staff_id], [customer_id], [total_price], [note]) VALUES (1, CAST(N'2020-03-25T16:09:23.933' AS DateTime), N'admin', 1, 8400, N'None')
INSERT [dbo].[ExportBill] ([id], [export_date], [staff_id], [customer_id], [total_price], [note]) VALUES (2, CAST(N'2020-03-25T16:09:51.677' AS DateTime), N'yasuo', 2, 45420, N'None')
INSERT [dbo].[ExportBill] ([id], [export_date], [staff_id], [customer_id], [total_price], [note]) VALUES (3, CAST(N'2020-03-25T16:10:04.027' AS DateTime), N'viet', 4, 38000, N'None')
INSERT [dbo].[ExportBill] ([id], [export_date], [staff_id], [customer_id], [total_price], [note]) VALUES (4, CAST(N'2020-03-25T16:10:14.470' AS DateTime), N'kien', 5, 33400, N'None')
INSERT [dbo].[ExportBill] ([id], [export_date], [staff_id], [customer_id], [total_price], [note]) VALUES (5, CAST(N'2020-03-25T16:10:24.097' AS DateTime), N'phong', 6, 37580, N'None')
INSERT [dbo].[ExportBill] ([id], [export_date], [staff_id], [customer_id], [total_price], [note]) VALUES (6, CAST(N'2020-03-25T16:10:30.360' AS DateTime), N'tuan', 7, 31500, N'None')
INSERT [dbo].[ExportBill] ([id], [export_date], [staff_id], [customer_id], [total_price], [note]) VALUES (7, CAST(N'2020-03-25T16:11:01.890' AS DateTime), N'staff', 3, 2700, N'None')
SET IDENTITY_INSERT [dbo].[ExportBill] OFF
SET IDENTITY_INSERT [dbo].[ImportBill] ON 

INSERT [dbo].[ImportBill] ([id], [import_date], [staff_id], [suplier_id], [total_price]) VALUES (2, CAST(N'2019-03-03T00:00:00.000' AS DateTime), N'admin', 2, 4000)
INSERT [dbo].[ImportBill] ([id], [import_date], [staff_id], [suplier_id], [total_price]) VALUES (3, CAST(N'2019-04-05T00:00:00.000' AS DateTime), N'staff', 1, 6000)
SET IDENTITY_INSERT [dbo].[ImportBill] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (1, N'LAPTOP-HP-UT23D', 1200, 1500, 35, 1, N'laptop1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (2, N'EARPHONES SONY U235T', 1100, 1350, 45, 5, N'earphone1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (3, N'LAPTOP-LENOVO-CT26Q', 2500, 3000, 40, 1, N'laptop2.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (4, N'TABLET-APPLE-CQ66Q', 5000, 9000, 20, 3, N'tablet1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (5, N'EARPHONES SONY Z2325RT', 500, 900, 25, 5, N'earphone2.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (6, N'LAPTOP-DELL-AO26Q', 5000, 6000, 40, 1, N'laptop3.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (7, N'PHONE-SAMSUNG-G5135F', 2000, 3500, 36, 4, N'phone1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (8, N'LAPTOP-ASUS-Z1000', 6000, 10000, 55, 1, N'laptop4.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (9, N'CAMERA_NIKON-A7', 3000, 8000, 40, 6, N'camera1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (10, N'LAPTOP-LENOVO-CT26Q', 2500, 3000, 40, 1, N'laptop2.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (11, N'TABLET-APPLE-CQ66Q', 5000, 9000, 20, 3, N'tablet1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (12, N'EARPHONES SONY Z2325RT', 500, 900, 25, 5, N'earphone2.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (13, N'LAPTOP-HP-UT23D', 1200, 1500, 35, 1, N'laptop1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (14, N'EARPHONES SONY U235T', 1100, 1350, 45, 5, N'earphone1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (15, N'LAPTOP-LENOVO-CT26Q', 2500, 3000, 40, 1, N'laptop2.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (16, N'LAPTOP-ASUS-Z1000', 6000, 10000, 55, 1, N'laptop4.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (17, N'CAMERA_NIKON-A7', 3000, 8000, 40, 6, N'camera1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (18, N'LAPTOP-LENOVO-CT26Q', 2500, 3000, 40, 1, N'laptop2.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (19, N'LAPTOP-HP-UT23D', 1200, 1500, 35, 1, N'laptop1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (20, N'EARPHONES SONY U235T', 1100, 1350, 45, 5, N'earphone1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (21, N'LAPTOP-LENOVO-CT26Q', 2500, 3000, 40, 1, N'laptop2.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (22, N'TABLET-APPLE-CQ66Q', 5000, 9000, 20, 3, N'tablet1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (23, N'TABLET-APPLE-CQ66Q', 5000, 9000, 20, 3, N'tablet1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (24, N'EARPHONES SONY Z2325RT', 500, 900, 25, 5, N'earphone2.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (25, N'LAPTOP-HP-UT23D', 1200, 1500, 35, 1, N'laptop1.png', 1)
INSERT [dbo].[Product] ([product_id], [product_name], [price_import], [price_sale], [quantity], [category_id], [image], [status_id]) VALUES (26, N'EARPHONES SONY U235T', 1100, 1350, 45, 5, N'earphone1.png', 1)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[Staff] ([staff_id], [staff_name], [dateOfBirth], [gender], [address], [note]) VALUES (N'viet', N'Khắc Việt', CAST(N'1999-12-20' AS Date), N'male', N'Hà Nội', N'none')
INSERT [dbo].[Staff] ([staff_id], [staff_name], [dateOfBirth], [gender], [address], [note]) VALUES (N'tuan', N'Anh Tuấn', CAST(N'1999-03-03' AS Date), N'female', N'HCM', N'none')
INSERT [dbo].[Staff] ([staff_id], [staff_name], [dateOfBirth], [gender], [address], [note]) VALUES (N'kien', N'Mạnh Kiên', CAST(N'1999-09-09' AS Date), N'male', N'Đà Nẵng', N'none')
INSERT [dbo].[Staff] ([staff_id], [staff_name], [dateOfBirth], [gender], [address], [note]) VALUES (N'phong', N'Công Phong', CAST(N'1999-04-12' AS Date), N'male', N'HCM', N'none')
INSERT [dbo].[Staff] ([staff_id], [staff_name], [dateOfBirth], [gender], [address], [note]) VALUES (N'hoang', N'Mạnh Hoàng', CAST(N'1999-10-11' AS Date), N'male', N'Hà Nội', N'none')
INSERT [dbo].[Staff] ([staff_id], [staff_name], [dateOfBirth], [gender], [address], [note]) VALUES (N'yasuo', N'Yasuo', CAST(N'2005-09-09' AS Date), N'male', N'Hải Phòng', N'none')
INSERT [dbo].[Staff] ([staff_id], [staff_name], [dateOfBirth], [gender], [address], [note]) VALUES (N'staff', N'Teemo', CAST(N'2006-09-12' AS Date), N'female', N'HCM', N'none')
INSERT [dbo].[Staff] ([staff_id], [staff_name], [dateOfBirth], [gender], [address], [note]) VALUES (N'admin', N'Admintrator', CAST(N'1999-09-11' AS Date), N'male', N'HCM', N'none')
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([status_id], [status_name]) VALUES (1, N'Còn hàng')
INSERT [dbo].[Status] ([status_id], [status_name]) VALUES (2, N'Hết Hàng')
SET IDENTITY_INSERT [dbo].[Status] OFF
SET IDENTITY_INSERT [dbo].[Suplier] ON 

INSERT [dbo].[Suplier] ([suplier_id], [suplier_name], [address], [phone]) VALUES (1, N'Nam', N'Cà Mau', N'0957485133')
INSERT [dbo].[Suplier] ([suplier_id], [suplier_name], [address], [phone]) VALUES (2, N'Cường', N'HCM', N'0938432123')
INSERT [dbo].[Suplier] ([suplier_id], [suplier_name], [address], [phone]) VALUES (3, N'Mạnh', N'Hà Nội', N'0999963111')
INSERT [dbo].[Suplier] ([suplier_id], [suplier_name], [address], [phone]) VALUES (4, N'Hải', N'HCM', N'0917333211')
INSERT [dbo].[Suplier] ([suplier_id], [suplier_name], [address], [phone]) VALUES (5, N'Linh', N'HCM', N'0192734312')
SET IDENTITY_INSERT [dbo].[Suplier] OFF
ALTER TABLE [dbo].[Detail_ExportBill]  WITH CHECK ADD  CONSTRAINT [FK_Detail_ExportBill_ExportBill] FOREIGN KEY([export_id])
REFERENCES [dbo].[ExportBill] ([id])
GO
ALTER TABLE [dbo].[Detail_ExportBill] CHECK CONSTRAINT [FK_Detail_ExportBill_ExportBill]
GO
ALTER TABLE [dbo].[Detail_ExportBill]  WITH CHECK ADD  CONSTRAINT [FK_Detail_ExportBill_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Detail_ExportBill] CHECK CONSTRAINT [FK_Detail_ExportBill_Product]
GO
ALTER TABLE [dbo].[Detail_ImportBill]  WITH CHECK ADD  CONSTRAINT [FK_Detail_ImportBill_ImportBill] FOREIGN KEY([import_id])
REFERENCES [dbo].[ImportBill] ([id])
GO
ALTER TABLE [dbo].[Detail_ImportBill] CHECK CONSTRAINT [FK_Detail_ImportBill_ImportBill]
GO
ALTER TABLE [dbo].[Detail_ImportBill]  WITH CHECK ADD  CONSTRAINT [FK_Detail_ImportBill_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Detail_ImportBill] CHECK CONSTRAINT [FK_Detail_ImportBill_Product]
GO
ALTER TABLE [dbo].[ExportBill]  WITH CHECK ADD  CONSTRAINT [FK_ExportBill_Account] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[ExportBill] CHECK CONSTRAINT [FK_ExportBill_Account]
GO
ALTER TABLE [dbo].[ExportBill]  WITH CHECK ADD  CONSTRAINT [FK_ExportBill_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
GO
ALTER TABLE [dbo].[ExportBill] CHECK CONSTRAINT [FK_ExportBill_Customer]
GO
ALTER TABLE [dbo].[ImportBill]  WITH CHECK ADD  CONSTRAINT [FK_ImportBill_Account] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[ImportBill] CHECK CONSTRAINT [FK_ImportBill_Account]
GO
ALTER TABLE [dbo].[ImportBill]  WITH CHECK ADD  CONSTRAINT [FK_ImportBill_Suplier] FOREIGN KEY([suplier_id])
REFERENCES [dbo].[Suplier] ([suplier_id])
GO
ALTER TABLE [dbo].[ImportBill] CHECK CONSTRAINT [FK_ImportBill_Suplier]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([category_id])
REFERENCES [dbo].[Category] ([cate_id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Status] FOREIGN KEY([status_id])
REFERENCES [dbo].[Status] ([status_id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Status]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Account] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Account] ([username])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Account]
GO
USE [master]
GO
ALTER DATABASE [ElectricShop] SET  READ_WRITE 
GO
