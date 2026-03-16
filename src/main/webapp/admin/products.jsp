<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Admin</title>
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
            <i class="fas fa-box"></i> Quản lý sản phẩm
        </h2>
        
        <button onclick="showAddForm()" class="btn btn-primary" style="margin-bottom: 20px;">
            <i class="fas fa-plus-circle"></i> Thêm sách mới
        </button>
        
        <div id="addForm" style="display: none; background: white; padding: 20px; border-radius: 4px; margin-bottom: 20px;">
            <h4 style="color: #2d6a4f;">Thêm sách mới</h4>
            <form action="${pageContext.request.contextPath}/admin/products" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label>Tên sách:</label>
                    <input type="text" name="title" required>
                </div>
                <div class="form-group">
                    <label>Giá:</label>
                    <input type="number" name="price" step="0.01" required>
                </div>
                <div class="form-group">
                    <label>Mô tả:</label>
                    <textarea name="description" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label>Tác giả:</label>
                    <select name="authorId" required>
                        <c:forEach var="author" items="${authors}">
                            <option value="${author.authorId}">${author.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Thể loại:</label>
                    <select name="genreId" required>
                        <c:forEach var="genre" items="${genres}">
                            <option value="${genre.genreId}">${genre.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Trạng thái:</label>
                    <select name="status" required>
                        <option value="1">Hiển thị</option>
                        <option value="0">Ẩn</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Hình ảnh URL:</label>
                    <input type="text" name="imageUrl">
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Thêm
                </button>
                <button type="button" onclick="hideAddForm()" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Hủy
                </button>
            </form>
        </div>
        
        <div class="data-table">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên sách</th>
                        <th>Giá</th>
                        <th>Tác giả</th>
                        <th>Thể loại</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${books}">
                        <tr>
                            <td>${book.bookId}</td>
                            <td>${book.title}</td>
                            <td><fmt:formatNumber value="${book.price}" type="number" maxFractionDigits="0"/> VNĐ</td>
                            <td>${book.authorName}</td>
                            <td>${book.genreName}</td>
                            <td>
                                <c:if test="${book.status}">
                                    <span class="status-badge status-done">Hiển thị</span>
                                </c:if>
                                <c:if test="${!book.status}">
                                    <span class="status-badge status-wait">Ẩn</span>
                                </c:if>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/book?id=${book.bookId}" 
                                   class="btn btn-secondary" style="padding: 6px 12px; font-size: 13px; margin-right: 5px; text-decoration: none;">
                                    <i class="fas fa-eye"></i> Xem
                                </a>
                                <button onclick='showEditForm(${book.bookId})' 
                                        class="btn btn-primary" style="padding: 6px 12px; font-size: 13px; margin-right: 5px;">
                                    <i class="fas fa-edit"></i> Sửa
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/products" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="bookId" value="${book.bookId}">
                                    <button type="submit" class="btn btn-danger" style="padding: 6px 12px; font-size: 13px;" 
                                            onclick="return confirm('Bạn có chắc muốn xóa sách này?')">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div id="editForm" style="display: none; background: white; padding: 20px; border-radius: 4px; margin-top: 20px;">
            <h4 style="color: #2d6a4f;">Sửa thông tin sách</h4>
            <form action="${pageContext.request.contextPath}/admin/products" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="bookId" id="editBookId">
                <div class="form-group">
                    <label>Tên sách:</label>
                    <input type="text" name="title" id="editTitle" required>
                </div>
                <div class="form-group">
                    <label>Giá:</label>
                    <input type="number" name="price" id="editPrice" step="0.01" required>
                </div>
                <div class="form-group">
                    <label>Mô tả:</label>
                    <textarea name="description" id="editDescription" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label>Tác giả:</label>
                    <select name="authorId" id="editAuthorId" required>
                        <c:forEach var="author" items="${authors}">
                            <option value="${author.authorId}">${author.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Thể loại:</label>
                    <select name="genreId" id="editGenreId" required>
                        <c:forEach var="genre" items="${genres}">
                            <option value="${genre.genreId}">${genre.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Trạng thái:</label>
                    <select name="status" id="editStatus" required>
                        <option value="1">Hiển thị</option>
                        <option value="0">Ẩn</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Hình ảnh URL:</label>
                    <input type="text" name="imageUrl" id="editImageUrl">
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Cập nhật
                </button>
                <button type="button" onclick="hideEditForm()" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Hủy
                </button>
            </form>
        </div>
    </div>
    
    <script>
        function showAddForm() {
            document.getElementById('addForm').style.display = 'block';
            window.scrollTo(0, 0);
        }
        function hideAddForm() {
            document.getElementById('addForm').style.display = 'none';
        }
        function showEditForm(bookId) {
            // Tìm thông tin sách từ bảng
            var books = {
                <c:forEach var="book" items="${books}" varStatus="status">
                ${book.bookId}: {
                    title: `${book.title}`,
                    price: ${book.price},
                    description: `${book.description}`,
                    authorId: ${book.authorId},
                    genreId: ${book.genreId},
                    status: ${book.status},
                    imageUrl: `${book.imageUrl}`
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            };
            
            var book = books[bookId];
            if (book) {
                document.getElementById('editBookId').value = bookId;
                document.getElementById('editTitle').value = book.title;
                document.getElementById('editPrice').value = book.price;
                document.getElementById('editDescription').value = book.description;
                document.getElementById('editAuthorId').value = book.authorId;
                document.getElementById('editGenreId').value = book.genreId;
                document.getElementById('editStatus').value = book.status ? '1' : '0';
                document.getElementById('editImageUrl').value = book.imageUrl;
                document.getElementById('editForm').style.display = 'block';
                document.getElementById('editForm').scrollIntoView({ behavior: 'smooth' });
            }
        }
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
