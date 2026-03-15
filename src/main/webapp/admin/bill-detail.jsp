<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết hóa đơn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-header">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h2>Chi tiết hóa đơn #${order.orderId}</h2>
                <p>Welcome: ${sessionScope.admin.username}</p>
            </div>
            <div style="display: flex; gap: 10px;">
                <a href="${pageContext.request.contextPath}/admin/bills" class="btn btn-secondary">Quay lại</a>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
    
    <div class="admin-container">
        <div style="background: white; padding: 20px; border-radius: 4px; margin-bottom: 20px;">
            <h3 style="color: #2d6a4f;">Thông tin hóa đơn</h3>
            <p><strong>Mã hóa đơn:</strong> ${order.orderId}</p>
            <p><strong>Khách hàng:</strong> ${order.customerName}</p>
            <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
            <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.totalPrice}" type="number" maxFractionDigits="0"/> VNĐ</p>
            <p><strong>Trạng thái:</strong> 
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
            </p>
            
            <div style="margin-top: 20px;">
                <h4 style="color: #2d6a4f;">Cập nhật trạng thái:</h4>
                <form action="${pageContext.request.contextPath}/admin/bills" method="post" style="display: flex; gap: 10px; margin-top: 10px;">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <select name="status" class="form-group" style="padding: 8px; border-radius: 4px; border: 1px solid #d8f3dc;">
                        <option value="wait" ${order.status eq 'wait' ? 'selected' : ''}>Chờ xử lý</option>
                        <option value="process" ${order.status eq 'process' ? 'selected' : ''}>Đang xử lý</option>
                        <option value="done" ${order.status eq 'done' ? 'selected' : ''}>Hoàn thành</option>
                    </select>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </form>
            </div>
        </div>
        
        <h3 style="color: #2d6a4f; margin-bottom: 20px;">Chi tiết sản phẩm</h3>
        <div class="data-table">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên sách</th>
                        <th>Số lượng</th>
                        <th>Giá</th>
                        <th>Tổng cộng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${orderItems}">
                        <tr>
                            <td>${item.bookId}</td>
                            <td>${item.book.title}</td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.price}" type="number" maxFractionDigits="0"/> VNĐ</td>
                            <td><fmt:formatNumber value="${item.totalPrice}" type="number" maxFractionDigits="0"/> VNĐ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
