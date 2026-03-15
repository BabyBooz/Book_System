<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="form-container">
        <h2 style="color: #2d6a4f;">Đặt hàng thành công!</h2>
        
        <div class="alert alert-success">
            ${success}
        </div>
        
        <p style="text-align: center; margin: 20px 0;">
            Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đang được xử lý.
        </p>
        
        <div style="text-align: center;">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Quay lại trang chủ</a>
        </div>
    </div>
</body>
</html>
