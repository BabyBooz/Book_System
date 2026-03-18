<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="logo">
                Admin Panel
            </a>
            <nav class="nav-menu">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/customers">Khách hàng</a>
                <a href="${pageContext.request.contextPath}/admin/products">Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/admin/genres">Danh mục</a>
                <a href="${pageContext.request.contextPath}/admin/bills">Đơn hàng</a>
                <span class="user-info">${sessionScope.admin.username}</span>
                <a href="${pageContext.request.contextPath}/admin/logout">Đăng xuất</a>
            </nav>
        </div>
    </header>
    
    <div class="container">
        <div style="padding: 15px; background: #f0f0f0; border: 2px solid #999; margin-bottom: 20px;">
            <h1 style="font-size: 24px; margin-bottom: 10px;">Admin Dashboard</h1>
            <p style="font-size: 14px;">Chào mừng: ${sessionScope.admin.fullName}</p>
            <p style="font-size: 14px;">Roll Number: ${sessionScope.admin.rollNumber}</p>
        </div>
        
        <table border="1" cellpadding="10" cellspacing="0" style="width: 100%; border: 2px solid #000;">
            <tr>
                <td style="width: 50%; padding: 20px; border: 2px solid #000;">
                    <h3 style="margin-bottom: 10px;">Quản lý khách hàng</h3>
                    <p style="margin-bottom: 15px;">Xem và quản lý danh sách khách hàng đã đăng ký</p>
                    <a href="${pageContext.request.contextPath}/admin/customers" class="btn btn-primary">Vào trang</a>
                </td>
                <td style="width: 50%; padding: 20px; border: 2px solid #000;">
                    <h3 style="margin-bottom: 10px;">Quản lý sản phẩm</h3>
                    <p style="margin-bottom: 15px;">Thêm, sửa, xóa và quản lý sách trong hệ thống</p>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary">Vào trang</a>
                </td>
            </tr>
            <tr>
                <td style="width: 50%; padding: 20px; border: 2px solid #000;">
                    <h3 style="margin-bottom: 10px;">Quản lý danh mục</h3>
                    <p style="margin-bottom: 15px;">Thêm, sửa, xóa các thể loại sách</p>
                    <a href="${pageContext.request.contextPath}/admin/genres" class="btn btn-primary">Vào trang</a>
                </td>
                <td style="width: 50%; padding: 20px; border: 2px solid #000;">
                    <h3 style="margin-bottom: 10px;">Quản lý đơn hàng</h3>
                    <p style="margin-bottom: 15px;">Theo dõi và xử lý các đơn hàng của khách hàng</p>
                    <a href="${pageContext.request.contextPath}/admin/bills" class="btn btn-primary">Vào trang</a>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
