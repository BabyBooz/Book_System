package com.bookstore.servlet.admin;

import com.bookstore.dao.GenreDAO;
import com.bookstore.model.Genre;
import com.bookstore.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/genres")
public class GenreManagerServlet extends HttpServlet {
    private GenreDAO genreDAO = new GenreDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("admin");
        
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        List<Genre> genres = genreDAO.getAllGenres();
        request.setAttribute("genres", genres);
        request.getRequestDispatcher("/admin/genres.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            Genre genre = new Genre();
            genre.setName(request.getParameter("name"));
            genreDAO.addGenre(genre);
            
        } else if ("update".equals(action)) {
            Genre genre = new Genre();
            genre.setGenreId(Integer.parseInt(request.getParameter("genreId")));
            genre.setName(request.getParameter("name"));
            genreDAO.updateGenre(genre);
            
        } else if ("delete".equals(action)) {
            int genreId = Integer.parseInt(request.getParameter("genreId"));
            genreDAO.deleteGenre(genreId);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/genres");
    }
}
