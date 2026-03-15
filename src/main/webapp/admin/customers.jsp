<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-header">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h2>Customer Manager</h2>
                <p>Welcome: ${sessionScope.admin.username}</p>
            </div>
            <div style="display: flex; gap: 10px;">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
    
    <div class="admin-container">
        <h3 style="color: #2d6a4f; margin-bottom: 20px;">Danh sách khách hàng</h3>
        
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
                                    <button type="submit" class="btn btn-danger" style="padding: 4px 8px; font-size: 12px;" 
                                            onclick="return confirm('Bạn có chắc muốn xóa khách hàng này?')">Xóa</button>
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
