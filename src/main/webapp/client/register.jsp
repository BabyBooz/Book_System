<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Cửa hàng sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/" class="logo">
                <i class="fas fa-book"></i> Cửa hàng sách
            </a>
            <nav class="nav-menu">
                <a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Trang chủ</a>
                <a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Đăng nhập</a>
            </nav>
        </div>
    </header>

    <div class="form-container">
        <h2><i class="fas fa-user-plus"></i> Đăng ký tài khoản</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label><i class="fas fa-id-card"></i> Mã số học viên:</label>
                <input type="text" name="rollNumber" required placeholder="Nhập mã số học viên">
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-user"></i> Họ và tên:</label>
                <input type="text" name="fullName" required placeholder="Nhập họ và tên đầy đủ">
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-user-circle"></i> Tên đăng nhập:</label>
                <input type="text" name="username" required placeholder="Chọn tên đăng nhập">
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-lock"></i> Mật khẩu:</label>
                <input type="password" name="password" required placeholder="Tạo mật khẩu">
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-envelope"></i> Email:</label>
                <input type="email" name="email" placeholder="email@example.com">
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-phone"></i> Số điện thoại:</label>
                <input type="text" name="phone" placeholder="Nhập số điện thoại">
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-map-marker-alt"></i> Địa chỉ:</label>
                <textarea name="address" rows="3" placeholder="Nhập địa chỉ của bạn"></textarea>
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%;">
                <i class="fas fa-user-plus"></i> Đăng ký
            </button>
        </form>
        
        <p style="text-align: center; margin-top: 20px; color: #666;">
            Đã có tài khoản? 
            <a href="${pageContext.request.contextPath}/login" style="color: #2d6a4f; font-weight: 600; text-decoration: none;">
                Đăng nhập ngay <i class="fas fa-arrow-right"></i>
            </a>
        </p>
    </div>
</body>
</html>
