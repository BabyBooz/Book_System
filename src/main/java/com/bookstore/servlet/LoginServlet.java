package com.bookstore.servlet;

import com.bookstore.dao.UserDAO;
import com.bookstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/client/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = userDAO.login(username, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            
            // Phân quyền dựa trên role
            if ("admin".equals(user.getRole())) {
                // Admin: set session admin và redirect đến admin dashboard
                session.setAttribute("admin", user);
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else if ("customer".equals(user.getRole())) {
                // Customer: set session user và redirect đến trang chủ
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/");
            } else {
                request.setAttribute("error", "Role không hợp lệ!");
                request.getRequestDispatcher("/client/login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/client/login.jsp").forward(request, response);
        }
    }
}
