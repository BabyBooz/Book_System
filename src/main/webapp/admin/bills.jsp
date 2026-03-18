<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng - Admin</title>
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
            <i class="fas fa-file-invoice"></i> Quản lý đơn hàng
        </h2>
        
        <div style="margin-bottom: 20px; display: flex; gap: 10px;">
            <a href="${pageContext.request.contextPath}/admin/bills" class="btn ${empty currentStatus ? 'btn-primary' : 'btn-secondary'}">
                <i class="fas fa-list"></i> Tất cả
            </a>
        </div>
        
        <div class="data-table">
            <table>
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Customer Name</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.customerName}</td>
                            <td><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td><fmt:formatNumber value="${order.totalPrice}" type="number" maxFractionDigits="0"/> VNĐ</td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status eq 'wait'}">
                                        <span class="status-badge status-wait">Chờ xử lý</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'process'}">
                                        <span class="status-badge status-process">Đang xử lý</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'done'}">
                                        <span class="status-badge status-done">Hoàn thành</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/bills?orderId=${order.orderId}" 
                                   class="btn btn-primary" style="padding: 6px 12px; font-size: 13px;">
                                    <i class="fas fa-eye"></i> Xem
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
