<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Cửa hàng sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/" class="logo">
                Cửa hàng sách
            </a>
            <nav class="nav-menu">
                <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="user-info">${sessionScope.user.fullName}</span>
                        <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
                        <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                    </c:when>
                    <c:when test="${not empty sessionScope.admin}">
                        <span class="user-info">Admin: ${sessionScope.admin.fullName}</span>
                        <a href="${pageContext.request.contextPath}/admin/dashboard">Admin Panel</a>
                        <a href="${pageContext.request.contextPath}/admin/logout">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </header>

    <div class="container">
        <!-- Category Filter -->
        <div style="background: #f0f0f0; padding: 15px; border: 2px solid #999; margin-bottom: 20px;">
            <h3 style="margin-bottom: 10px;">Danh mục sản phẩm:</h3>
            <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/" 
                   class="btn ${empty param.genreId ? 'btn-primary' : 'btn-secondary'}">
                    Tất cả
                </a>
                <c:forEach var="genre" items="${genres}">
                    <a href="${pageContext.request.contextPath}/?genreId=${genre.genreId}" 
                       class="btn ${param.genreId == genre.genreId ? 'btn-primary' : 'btn-secondary'}">
                        ${genre.name}
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- Page Title -->
        <h2 style="margin-bottom: 20px; font-size: 24px;">
            <c:choose>
                <c:when test="${not empty param.genreId}">
                    <c:forEach var="genre" items="${genres}">
                        <c:if test="${genre.genreId == param.genreId}">
                            ${genre.name}
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    Tất cả sản phẩm
                </c:otherwise>
            </c:choose>
        </h2>

        <!-- Books Grid -->
        <div class="book-grid">
            <c:forEach var="book" items="${books}">
                <div class="book-card">
                    <div class="book-image">
                        <c:choose>
                            <c:when test="${not empty book.imageUrl and book.imageUrl ne 'null'}">
                                <img src="${pageContext.request.contextPath}/${book.imageUrl}" 
                                     alt="${book.title}" 
                                     style="width: 100%; height: 100%; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                No Image
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="book-title">${book.title}</div>
                    <div class="book-author">Tác giả: ${book.authorName}</div>
                    <div class="book-price">
                        Giá: <fmt:formatNumber value="${book.price}" type="number" maxFractionDigits="0"/> VNĐ
                    </div>
                    <div class="book-description">${book.description}</div>
                    
                    <div style="margin-top: auto; display: flex; flex-direction: column; gap: 10px;">
                        <a href="${pageContext.request.contextPath}/book?id=${book.bookId}" 
                           class="btn btn-secondary" style="width: 100%; text-align: center; text-decoration: none;">
                            Xem chi tiết
                        </a>
                        
                        <c:if test="${not empty sessionScope.user}">
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="bookId" value="${book.bookId}">
                                <button type="submit" class="btn btn-primary" style="width: 100%;">
                                    Thêm vào giỏ
                                </button>
                            </form>
                        </c:if>
                        <c:if test="${empty sessionScope.user and empty sessionScope.admin}">
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary" 
                               style="width: 100%; text-align: center; text-decoration: none;">
                                Đăng nhập để mua
                            </a>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
