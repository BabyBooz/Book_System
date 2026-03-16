<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Admin</title>
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
            <i class="fas fa-tags"></i> Quản lý danh mục sách
        </h2>
        
        <button onclick="showAddForm()" class="btn btn-primary" style="margin-bottom: 20px;">
            <i class="fas fa-plus-circle"></i> Thêm danh mục mới
        </button>
        
        <!-- Add Form -->
        <div id="addForm" style="display: none; background: white; padding: 20px; border-radius: 12px; margin-bottom: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.08);">
            <h4 style="color: #2d6a4f; margin-bottom: 15px;">
                <i class="fas fa-plus"></i> Thêm danh mục mới
            </h4>
            <form action="${pageContext.request.contextPath}/admin/genres" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label><i class="fas fa-tag"></i> Tên danh mục:</label>
                    <input type="text" name="name" required placeholder="Ví dụ: Văn học, Khoa học, Lịch sử...">
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Thêm
                </button>
                <button type="button" onclick="hideAddForm()" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Hủy
                </button>
            </form>
        </div>
        
        <!-- Genres Table -->
        <div class="data-table">
            <table>
                <thead>
                    <tr>
                        <th style="width: 100px;">ID</th>
                        <th>Tên danh mục</th>
                        <th style="width: 250px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="genre" items="${genres}">
                        <tr>
                            <td>${genre.genreId}</td>
                            <td>${genre.name}</td>
                            <td>
                                <button onclick='showEditForm(${genre.genreId})' 
                                        class="btn btn-primary" style="padding: 6px 12px; font-size: 13px; margin-right: 5px;">
                                    <i class="fas fa-edit"></i> Sửa
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/genres" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="genreId" value="${genre.genreId}">
                                    <button type="submit" class="btn btn-danger" style="padding: 6px 12px; font-size: 13px;" 
                                            onclick="return confirm('Bạn có chắc muốn xóa danh mục này? Lưu ý: Các sách thuộc danh mục này có thể bị ảnh hưởng.')">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Edit Form -->
        <div id="editForm" style="display: none; background: white; padding: 20px; border-radius: 12px; margin-top: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.08);">
            <h4 style="color: #2d6a4f; margin-bottom: 15px;">
                <i class="fas fa-edit"></i> Sửa thông tin danh mục
            </h4>
            <form action="${pageContext.request.contextPath}/admin/genres" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="genreId" id="editGenreId">
                <div class="form-group">
                    <label><i class="fas fa-tag"></i> Tên danh mục:</label>
                    <input type="text" name="name" id="editName" required>
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
        function showEditForm(genreId) {
            var genres = {
                <c:forEach var="genre" items="${genres}" varStatus="status">
                ${genre.genreId}: {
                    name: `${genre.name}`
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            };
            
            var genre = genres[genreId];
            if (genre) {
                document.getElementById('editGenreId').value = genreId;
                document.getElementById('editName').value = genre.name;
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
