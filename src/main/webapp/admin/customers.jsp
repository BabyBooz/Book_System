<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý khách hàng - Admin</title>
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
    
    <div class="admin-container">
        <h2 style="color: #2d6a4f; margin-bottom: 30px; font-size: 32px;">
            <i class="fas fa-users"></i> Danh sách khách hàng
        </h2>
        
        <div class="data-table">
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Roll Number</th>
                        <th>Full Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td>${customer.userId}</td>
                            <td>${customer.rollNumber}</td>
                            <td>${customer.fullName}</td>
                            <td>${customer.username}</td>
                            <td>${customer.email}</td>
                            <td>${customer.phone}</td>
                            <td>${customer.address}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/customers" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="userId" value="${customer.userId}">
                                    <button type="submit" class="btn btn-danger" style="padding: 6px 12px; font-size: 13px;" 
                                            onclick="return confirm('Bạn có chắc muốn xóa khách hàng này?')">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
