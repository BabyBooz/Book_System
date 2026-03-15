<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="form-container">
        <h2>Đăng nhập</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Tên đăng nhập:</label>
                <input type="text" name="username" required>
            </div>
            
            <div class="form-group">
                <label>Mật khẩu:</label>
                <input type="password" name="password" required>
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%;">Đăng nhập</button>
        </form>
        
        <p style="text-align: center; margin-top: 15px;">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" style="color: #2d6a4f;">Đăng ký ngay</a>
        </p>
        
        <p style="text-align: center; margin-top: 10px;">
            <a href="${pageContext.request.contextPath}/" style="color: #2d6a4f;">Quay lại trang chủ</a>
        </p>
    </div>
</body>
</html>
