<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng sách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
    <!-- Banner -->
    <div class="banner">
        <div class="banner-info">
            <c:if test="${not empty sessionScope.user}">
                <span>Roll Number: ${sessionScope.user.rollNumber}</span>
                <span>Full Name: ${sessionScope.user.fullName}</span>
                <span>Welcome: ${sessionScope.user.username}</span>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <span>Welcome: Guest</span>
            </c:if>
        </div>
        <div class="banner-actions">
            <c:if test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">Register</a>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-primary">Show Cart</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a>
            </c:if>
        </div>
    </div>

    <!-- Menu -->
    <div class="menu">
        <h3>Thể loại</h3>
        <div class="menu-list">
            <a href="${pageContext.request.contextPath}/" class="menu-item">Tất cả</a>
            <c:forEach var="genre" items="${genres}">
                <a href="${pageContext.request.contextPath}/?genreId=${genre.genreId}" class="menu-item">${genre.name}</a>
            </c:forEach>
        </div>
    </div>

    <!-- Content -->
    <div class="content">
        <h2 style="color: #2d6a4f; margin-bottom: 20px;">Danh sách sách</h2>
        <div class="book-grid">
            <c:forEach var="book" items="${books}">
                <div class="book-card">
                    <div class="book-image" style="background-color: #d8f3dc; display: flex; align-items: center; justify-content: center; color: #2d6a4f;">
                        ${book.imageUrl}
                    </div>
                    <div class="book-title">${book.title}</div>
                    <div class="book-author">Tác giả: ${book.authorName}</div>
                    <div class="book-price"><fmt:formatNumber value="${book.price}" type="number" maxFractionDigits="0"/> VNĐ</div>
                    <div class="book-description">${book.description}</div>
                    <c:if test="${not empty sessionScope.user}">
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="bookId" value="${book.bookId}">
                            <button type="submit" class="btn btn-primary" style="width: 100%;">Add to Cart</button>
                        </form>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary" style="width: 100%; text-align: center;">Login to buy</a>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
