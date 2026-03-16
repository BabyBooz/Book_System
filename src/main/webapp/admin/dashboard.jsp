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
                <i class="fas fa-user-shield"></i> Admin Panel
            </a>
            <nav class="nav-menu">
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/customers">
                    <i class="fas fa-users"></i> Khách hàng
                </a>
                <a href="${pageContext.request.contextPath}/admin/products">
                    <i class="fas fa-box"></i> Sản phẩm
                </a>
                <a href="${pageContext.request.contextPath}/admin/genres">
                    <i class="fas fa-tags"></i> Danh mục
                </a>
                <a href="${pageContext.request.contextPath}/admin/bills">
                    <i class="fas fa-file-invoice"></i> Đơn hàng
                </a>
                <span class="user-info">
                    <i class="fas fa-user"></i> ${sessionScope.admin.username}
                </span>
                <a href="${pageContext.request.contextPath}/admin/logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </nav>
        </div>
    </header>
    
    <div class="container" style="margin-top: 50px;">
        <div class="hero-section" style="padding: 60px 40px;">
            <h1 style="font-size: 42px;"><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h1>
            <p style="font-size: 18px; margin-top: 15px;">Chào mừng ${sessionScope.admin.fullName}</p>
            <p style="font-size: 16px; opacity: 0.9;">Roll Number: ${sessionScope.admin.rollNumber}</p>
        </div>
        
        <div class="features">
            <a href="${pageContext.request.contextPath}/admin/customers" class="feature-card" style="text-decoration: none; color: inherit;">
                <h3><i class="fas fa-users"></i> Quản lý khách hàng</h3>
                <p>Xem và quản lý danh sách khách hàng đã đăng ký</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/products" class="feature-card" style="text-decoration: none; color: inherit;">
                <h3><i class="fas fa-box"></i> Quản lý sản phẩm</h3>
                <p>Thêm, sửa, xóa và quản lý sách trong hệ thống</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/genres" class="feature-card" style="text-decoration: none; color: inherit;">
                <h3><i class="fas fa-tags"></i> Quản lý danh mục</h3>
                <p>Thêm, sửa, xóa các thể loại sách</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/bills" class="feature-card" style="text-decoration: none; color: inherit;">
                <h3><i class="fas fa-file-invoice"></i> Quản lý đơn hàng</h3>
                <p>Theo dõi và xử lý các đơn hàng của khách hàng</p>
            </a>
        </div>
    </div>
</body>
</html>
