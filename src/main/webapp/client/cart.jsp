<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - Cửa hàng sách</title>
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
                <span class="user-info">
                    <i class="fas fa-user"></i> ${sessionScope.user.fullName}
                </span>
                <a href="${pageContext.request.contextPath}/cart">
                    <i class="fas fa-shopping-cart"></i> Giỏ hàng
                </a>
                <a href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </nav>
        </div>
    </header>

    <div class="container" style="margin-top: 30px;">
        <h2 style="color: #2d6a4f; margin-bottom: 30px; font-size: 32px;">
            <i class="fas fa-shopping-cart"></i> Giỏ hàng của bạn
        </h2>
        
        <c:if test="${empty cartItems}">
            <div class="alert alert-error">
                <i class="fas fa-info-circle"></i> Giỏ hàng trống!
            </div>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
            </a>
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
                                        <button type="submit" class="btn btn-primary" style="padding: 6px 12px; font-size: 13px;">
                                            <i class="fas fa-sync-alt"></i> Cập nhật
                                        </button>
                                    </form>
                                </td>
                                <td><fmt:formatNumber value="${item.book.price}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                <td><fmt:formatNumber value="${item.totalPrice}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                        <button type="submit" class="btn btn-danger" style="padding: 6px 12px; font-size: 13px;">
                                            <i class="fas fa-trash"></i> Xóa
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <div class="cart-summary">
                <h3><i class="fas fa-calculator"></i> Tổng tiền: <fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/> VNĐ</h3>
                <div class="cart-actions">
                    <form action="${pageContext.request.contextPath}/checkout" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-credit-card"></i> Thanh toán
                        </button>
                    </form>
                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="removeAll">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa tất cả?')">
                            <i class="fas fa-trash-alt"></i> Xóa tất cả
                        </button>
                    </form>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                        <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>
