package com.bookstore.filter;

import com.bookstore.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        
        // Cho phép truy cập trang login
        if (requestURI.endsWith("/admin/login") || requestURI.endsWith("/admin/login.jsp")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Kiểm tra session admin
        if (session == null || session.getAttribute("admin") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login");
            return;
        }
        
        // Kiểm tra role
        User admin = (User) session.getAttribute("admin");
        if (!"admin".equals(admin.getRole())) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login");
            return;
        }
        
        // Cho phép truy cập
        chain.doFilter(request, response);
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
