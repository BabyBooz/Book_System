package com.bookstore.servlet.admin;

import com.bookstore.dao.AuthorDAO;
import com.bookstore.dao.BookDAO;
import com.bookstore.dao.GenreDAO;
import com.bookstore.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/products")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProductManagerServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();
    private AuthorDAO authorDAO = new AuthorDAO();
    private GenreDAO genreDAO = new GenreDAO();
    
    // Đường dẫn lưu ảnh
    private static final String UPLOAD_DIR = "images";
    
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
            addBook(request, response);
        } else if ("update".equals(action)) {
            updateBook(request, response);
        } else if ("delete".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            bookDAO.deleteBook(bookId);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
    private void addBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Book book = new Book();
        book.setTitle(request.getParameter("title"));
        book.setPrice(Double.parseDouble(request.getParameter("price")));
        book.setDescription(request.getParameter("description"));
        book.setAuthorId(Integer.parseInt(request.getParameter("authorId")));
        book.setGenreId(Integer.parseInt(request.getParameter("genreId")));
        book.setStatus("1".equals(request.getParameter("status")));
        
        // Xử lý upload ảnh
        String imageUrl = uploadImage(request);
        book.setImageUrl(imageUrl);
        
        bookDAO.addBook(book);
    }
    
    private void updateBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Book book = new Book();
        book.setBookId(Integer.parseInt(request.getParameter("bookId")));
        book.setTitle(request.getParameter("title"));
        book.setPrice(Double.parseDouble(request.getParameter("price")));
        book.setDescription(request.getParameter("description"));
        book.setAuthorId(Integer.parseInt(request.getParameter("authorId")));
        book.setGenreId(Integer.parseInt(request.getParameter("genreId")));
        book.setStatus("1".equals(request.getParameter("status")));
        
        // Xử lý upload ảnh mới (nếu có)
        String imageUrl = uploadImage(request);
        if (imageUrl != null && !imageUrl.isEmpty()) {
            book.setImageUrl(imageUrl);
        } else {
            // Giữ nguyên ảnh cũ
            book.setImageUrl(request.getParameter("oldImageUrl"));
        }
        
        bookDAO.updateBook(book);
    }
    
    private String uploadImage(HttpServletRequest request) throws ServletException, IOException {
        Part filePart = request.getPart("image");
        
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // Kiểm tra định dạng file
        String fileExtension = "";
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = fileName.substring(dotIndex).toLowerCase();
        }
        
        if (!fileExtension.matches("\\.(jpg|jpeg|png|gif|webp)")) {
            return null;
        }
        
        // Tạo tên file unique
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        
        // Lấy đường dẫn thực tế của project (src/main/webapp/images)
        String realPath = getServletContext().getRealPath("/" + UPLOAD_DIR);
        String projectPath = realPath.replace("target" + File.separator + "Book_System-1", 
                                             "src" + File.separator + "main" + File.separator + "webapp");
        
        System.out.println("=== UPLOAD DEBUG ===");
        System.out.println("Real Path: " + realPath);
        System.out.println("Project Path: " + projectPath);
        
        // Tạo thư mục nếu chưa tồn tại
        File uploadDir = new File(projectPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
            System.out.println("Created directory: " + projectPath);
        }
        
        // Lưu file vào thư mục nguồn (src/main/webapp/images)
        String filePath = projectPath + File.separator + uniqueFileName;
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("File saved to SRC: " + filePath);
        }
        
        // Copy sang thư mục target để hiển thị ngay
        String targetPath = realPath + File.separator + uniqueFileName;
        File targetDir = new File(realPath);
        if (!targetDir.exists()) {
            targetDir.mkdirs();
        }
        Files.copy(Paths.get(filePath), Paths.get(targetPath), StandardCopyOption.REPLACE_EXISTING);
        System.out.println("File copied to TARGET: " + targetPath);
        
        // Trả về đường dẫn tương đối để lưu vào database
        return UPLOAD_DIR + "/" + uniqueFileName;
    }
}
