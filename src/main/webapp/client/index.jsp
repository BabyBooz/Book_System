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

    <!-- Main Layout with Sidebar -->
    <div class="page-wrapper">
        <!-- Sidebar Categories -->
        <aside class="sidebar-categories">
            <div class="sidebar-header">
                <h3><i class="fas fa-list"></i> Danh mục</h3>
            </div>
            <ul class="category-list">
                <li>
                    <a href="${pageContext.request.contextPath}/" 
                       class="category-item ${empty param.genreId ? 'active' : ''}">
                        <i class="fas fa-th"></i> Tất cả sản phẩm
                    </a>
                </li>
                <c:forEach var="genre" items="${genres}">
                    <li>
                        <a href="${pageContext.request.contextPath}/?genreId=${genre.genreId}" 
                           class="category-item ${param.genreId == genre.genreId ? 'active' : ''}">
                            <i class="fas fa-bookmark"></i> ${genre.name}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </aside>

        <!-- Main Content Area -->
        <main class="main-content-area">
            <div class="content-header">
                <h2>
                    <i class="fas fa-book"></i> 
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
            </div>

            <div class="book-grid">
                <c:forEach var="book" items="${books}">
                    <div class="book-card">
                        <div class="book-image">
                            <i class="fas fa-book" style="font-size: 48px; opacity: 0.5;"></i>
                        </div>
                        <div class="book-title">${book.title}</div>
                        <div class="book-author">
                            <i class="fas fa-user-edit"></i> ${book.authorName}
                        </div>
                        <div class="book-price">
                            <i class="fas fa-tag"></i> <fmt:formatNumber value="${book.price}" type="number" maxFractionDigits="0"/> VNĐ
                        </div>
                        <div class="book-description">${book.description}</div>
                        
                        <div style="margin-top: auto; display: flex; flex-direction: column; gap: 10px;">
                            <a href="${pageContext.request.contextPath}/book?id=${book.bookId}" 
                               class="btn btn-secondary" style="width: 100%; text-align: center; text-decoration: none;">
                                <i class="fas fa-eye"></i> Xem chi tiết
                            </a>
                            
                            <c:if test="${not empty sessionScope.user}">
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="bookId" value="${book.bookId}">
                                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                                        <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${empty sessionScope.user and empty sessionScope.admin}">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary" 
                                   style="width: 100%; text-align: center; text-decoration: none;">
                                    <i class="fas fa-sign-in-alt"></i> Đăng nhập để mua
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </main>
    </div>
</body>
</html>
