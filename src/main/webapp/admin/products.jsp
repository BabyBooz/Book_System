<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="admin-header">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h2>Product Manager</h2>
                <p>Welcome: ${sessionScope.admin.username}</p>
            </div>
            <div style="display: flex; gap: 10px;">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
    
    <div class="admin-container">
        <h3 style="color: #2d6a4f; margin-bottom: 20px;">Quản lý sản phẩm</h3>
        
        <button onclick="showAddForm()" class="btn btn-primary" style="margin-bottom: 20px;">Thêm sách mới</button>
        
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
                <button type="submit" class="btn btn-primary">Thêm</button>
                <button type="button" onclick="hideAddForm()" class="btn btn-secondary">Hủy</button>
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
                                <button onclick="showEditForm(${book.bookId}, '${book.title}', ${book.price}, '${book.description}', ${book.authorId}, ${book.genreId}, ${book.status}, '${book.imageUrl}')" 
                                        class="btn btn-primary" style="padding: 4px 8px; font-size: 12px;">Sửa</button>
                                <form action="${pageContext.request.contextPath}/admin/products" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="bookId" value="${book.bookId}">
                                    <button type="submit" class="btn btn-danger" style="padding: 4px 8px; font-size: 12px;" 
                                            onclick="return confirm('Bạn có chắc muốn xóa sách này?')">Xóa</button>
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
                <button type="submit" class="btn btn-primary">Cập nhật</button>
                <button type="button" onclick="hideEditForm()" class="btn btn-secondary">Hủy</button>
            </form>
        </div>
    </div>
    
    <script>
        function showAddForm() {
            document.getElementById('addForm').style.display = 'block';
        }
        function hideAddForm() {
            document.getElementById('addForm').style.display = 'none';
        }
        function showEditForm(id, title, price, desc, authorId, genreId, status, imageUrl) {
            document.getElementById('editBookId').value = id;
            document.getElementById('editTitle').value = title;
            document.getElementById('editPrice').value = price;
            document.getElementById('editDescription').value = desc;
            document.getElementById('editAuthorId').value = authorId;
            document.getElementById('editGenreId').value = genreId;
            document.getElementById('editStatus').value = status ? '1' : '0';
            document.getElementById('editImageUrl').value = imageUrl;
            document.getElementById('editForm').style.display = 'block';
        }
        function hideEditForm() {
            document.getElementById('editForm').style.display = 'none';
        }
    </script>
</body>
</html>
