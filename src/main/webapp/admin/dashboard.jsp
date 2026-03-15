<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-header">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h2>Admin Dashboard</h2>
                <p>Roll Number: ${sessionScope.admin.rollNumber}</p>
                <p>Full Name: ${sessionScope.admin.fullName}</p>
                <p>Welcome: ${sessionScope.admin.username}</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger">Logout</a>
            </div>
        </div>
        
        <div class="admin-menu">
            <a href="${pageContext.request.contextPath}/admin/customers" class="btn btn-primary">Customer Manager</a>
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary">Product Manager</a>
            <a href="${pageContext.request.contextPath}/admin/bills" class="btn btn-primary">Bill Manager</a>
        </div>
    </div>
    
    <div class="admin-container">
        <h3 style="color: #2d6a4f;">Chào mừng đến trang quản trị</h3>
        <p>Vui lòng chọn chức năng quản lý từ menu bên trên.</p>
    </div>
</body>
</html>
