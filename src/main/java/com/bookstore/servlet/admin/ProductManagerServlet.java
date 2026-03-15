package com.bookstore.servlet.admin;

import com.bookstore.dao.AuthorDAO;
import com.bookstore.dao.BookDAO;
import com.bookstore.dao.GenreDAO;
import com.bookstore.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class ProductManagerServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();
    private AuthorDAO authorDAO = new AuthorDAO();
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
        
        List<Book> books = bookDAO.getAllBooksForAdmin();
        List<Author> authors = authorDAO.getAllAuthors();
        List<Genre> genres = genreDAO.getAllGenres();
        
        request.setAttribute("books", books);
        request.setAttribute("authors", authors);
        request.setAttribute("genres", genres);
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            Book book = new Book();
            book.setTitle(request.getParameter("title"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setDescription(request.getParameter("description"));
            book.setAuthorId(Integer.parseInt(request.getParameter("authorId")));
            book.setGenreId(Integer.parseInt(request.getParameter("genreId")));
            book.setStatus("1".equals(request.getParameter("status")));
            book.setImageUrl(request.getParameter("imageUrl"));
            bookDAO.addBook(book);
            
        } else if ("update".equals(action)) {
            Book book = new Book();
            book.setBookId(Integer.parseInt(request.getParameter("bookId")));
            book.setTitle(request.getParameter("title"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setDescription(request.getParameter("description"));
            book.setAuthorId(Integer.parseInt(request.getParameter("authorId")));
            book.setGenreId(Integer.parseInt(request.getParameter("genreId")));
            book.setStatus("1".equals(request.getParameter("status")));
            book.setImageUrl(request.getParameter("imageUrl"));
            bookDAO.updateBook(book);
            
        } else if ("delete".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            bookDAO.deleteBook(bookId);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
