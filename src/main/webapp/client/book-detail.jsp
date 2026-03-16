<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book.title} - Cửa hàng sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
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
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="user-info">
                            <i class="fas fa-user"></i> ${sessionScope.user.fullName}
                        </span>
                        <a href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart"></i> Giỏ hàng
                        </a>
                        <a href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </c:when>
                    <c:when test="${not empty sessionScope.admin}">
                        <span class="user-info">
                            <i class="fas fa-user-shield"></i> Admin: ${sessionScope.admin.fullName}
                        </span>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" style="background: rgba(255,255,255,0.2);">
                            <i class="fas fa-tachometer-alt"></i> Admin Panel
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/logout">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                        <a href="${pageContext.request.contextPath}/register">
                            <i class="fas fa-user-plus"></i> Đăng ký
                        </a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </header>

    <div class="container" style="margin-top: 30px;">
        <div style="margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/" style="color: #2d6a4f; text-decoration: none;">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>

        <div class="book-detail-container">
            <div class="book-detail-image">
                <div style="width: 100%; height: 400px; background: linear-gradient(135deg, #d8f3dc 0%, #95d5b2 50%, #74c69d 100%); 
                            border-radius: 12px; display: flex; align-items: center; justify-content: center; 
                            box-shadow: 0 8px 16px rgba(0,0,0,0.1);">
                    <i class="fas fa-book" style="font-size: 120px; color: #2d6a4f; opacity: 0.5;"></i>
                </div>
            </div>
            
            <div class="book-detail-info">
                <h1 style="color: #2d6a4f; font-size: 36px; margin-bottom: 15px;">${book.title}</h1>
                
                <div style="margin-bottom: 20px;">
                    <p style="font-size: 18px; color: #666; margin-bottom: 10px;">
                        <i class="fas fa-user-edit"></i> <strong>Tác giả:</strong> ${book.authorName}
                    </p>
                    <p style="font-size: 18px; color: #666; margin-bottom: 10px;">
                        <i class="fas fa-bookmark"></i> <strong>Thể loại:</strong> ${book.genreName}
                    </p>
                </div>
                
                <div style="background: linear-gradient(135deg, #d8f3dc 0%, #b7e4c7 100%); 
                            padding: 20px; border-radius: 12px; margin-bottom: 25px;">
                    <p style="font-size: 32px; color: #2d6a4f; font-weight: bold; margin: 0;">
                        <i class="fas fa-tag"></i> <fmt:formatNumber value="${book.price}" type="number" maxFractionDigits="0"/> VNĐ
                    </p>
                </div>
                
                <div style="margin-bottom: 25px;">
                    <h3 style="color: #2d6a4f; margin-bottom: 10px; font-size: 20px;">
                        <i class="fas fa-info-circle"></i> Mô tả sản phẩm
                    </h3>
                    <p style="font-size: 16px; line-height: 1.8; color: #555; text-align: justify;">
                        ${book.description}
                    </p>
                </div>
                
                <c:if test="${not empty sessionScope.user}">
                    <form action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="bookId" value="${book.bookId}">
                        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 16px; font-size: 18px;">
                            <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                        </button>
                    </form>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary" 
                       style="width: 100%; text-align: center; padding: 16px; font-size: 18px; display: block; text-decoration: none;">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập để mua
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
