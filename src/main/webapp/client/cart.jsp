<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="banner">
        <div class="banner-info">
            <span>Roll Number: ${sessionScope.user.rollNumber}</span>
            <span>Full Name: ${sessionScope.user.fullName}</span>
            <span>Welcome: ${sessionScope.user.username}</span>
        </div>
        <div class="banner-actions">
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a>
        </div>
    </div>

    <div class="content">
        <h2 style="color: #2d6a4f; margin-bottom: 20px;">Giỏ hàng của bạn</h2>
        
        <c:if test="${empty cartItems}">
            <div class="alert alert-error">Giỏ hàng trống!</div>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Tiếp tục mua sắm</a>
        </c:if>
        
        <c:if test="${not empty cartItems}">
            <div class="cart-table">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên sách</th>
                            <th>Số lượng</th>
                            <th>Giá</th>
                            <th>Tổng cộng</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr>
                                <td>${item.book.bookId}</td>
                                <td>${item.book.title}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                        <input type="hidden" name="price" value="${item.book.price}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" style="width: 60px;">
                                        <button type="submit" class="btn btn-primary" style="padding: 4px 8px; font-size: 12px;">Update</button>
                                    </form>
                                </td>
                                <td><fmt:formatNumber value="${item.book.price}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                <td><fmt:formatNumber value="${item.totalPrice}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                        <button type="submit" class="btn btn-danger" style="padding: 4px 8px; font-size: 12px;">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <div class="cart-summary">
                <h3>Tổng tiền: <fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/> VNĐ</h3>
                <div class="cart-actions">
                    <form action="${pageContext.request.contextPath}/checkout" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-primary">Check out</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="removeAll">
                        <button type="submit" class="btn btn-danger">Remove All</button>
                    </form>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Tiếp tục mua sắm</a>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>
