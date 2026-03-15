package com.bookstore.servlet;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.GenreDAO;
import com.bookstore.model.Book;
import com.bookstore.model.Genre;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/", "/home"})
public class HomeServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();
    private GenreDAO genreDAO = new GenreDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String genreIdParam = request.getParameter("genreId");
        
        List<Genre> genres = genreDAO.getAllGenres();
        List<Book> books;
        
        if (genreIdParam != null && !genreIdParam.isEmpty()) {
            int genreId = Integer.parseInt(genreIdParam);
            books = bookDAO.getBooksByGenre(genreId);
        } else {
            books = bookDAO.getAllBooks();
        }
        
        request.setAttribute("genres", genres);
        request.setAttribute("books", books);
        request.getRequestDispatcher("/client/index.jsp").forward(request, response);
    }
}
