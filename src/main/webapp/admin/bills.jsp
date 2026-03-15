<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-header">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h2>Bill Manager</h2>
                <p>Welcome: ${sessionScope.admin.username}</p>
            </div>
            <div style="display: flex; gap: 10px;">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
    
    <div class="admin-container">
        <h3 style="color: #2d6a4f; margin-bottom: 20px;">Quản lý hóa đơn</h3>
        
        <div style="margin-bottom: 20px; display: flex; gap: 10px;">
            <a href="${pageContext.request.contextPath}/admin/bills" class="btn ${empty currentStatus ? 'btn-primary' : 'btn-secondary'}">Tất cả</a>
            <a href="${pageContext.request.contextPath}/admin/bills?status=wait" class="btn ${'wait' eq currentStatus ? 'btn-primary' : 'btn-secondary'}">Chờ xử lý</a>
            <a href="${pageContext.request.contextPath}/admin/bills?status=process" class="btn ${'process' eq currentStatus ? 'btn-primary' : 'btn-secondary'}">Đang xử lý</a>
            <a href="${pageContext.request.contextPath}/admin/bills?status=done" class="btn ${'done' eq currentStatus ? 'btn-primary' : 'btn-secondary'}">Hoàn thành</a>
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
                                   class="btn btn-primary" style="padding: 4px 8px; font-size: 12px;">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
