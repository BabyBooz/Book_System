<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
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
            </nav>
        </div>
    </header>

    <div class="form-container">
        <h2><i class="fas fa-user-shield"></i> Admin Login</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="form-group">
                <label><i class="fas fa-user"></i> Username:</label>
                <input type="text" name="username" required placeholder="Nhập tên đăng nhập admin">
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-lock"></i> Password:</label>
                <input type="password" name="password" required placeholder="Nhập mật khẩu">
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%;">
                <i class="fas fa-sign-in-alt"></i> Đăng nhập
            </button>
        </form>
        
        <p style="text-align: center; margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/" style="color: #2d6a4f; text-decoration: none;">
                <i class="fas fa-arrow-left"></i> Về trang chủ
            </a>
        </p>
    </div>
</body>
</html>
