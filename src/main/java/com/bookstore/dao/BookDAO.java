package com.bookstore.dao;

import com.bookstore.model.Book;
import com.bookstore.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, a.name as author_name, g.name as genre_name " +
                     "FROM books b " +
                     "LEFT JOIN authors a ON b.author_id = a.author_id " +
                     "LEFT JOIN genres g ON b.genre_id = g.genre_id " +
                     "WHERE b.status = 1";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                books.add(extractBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    public List<Book> getBooksByGenre(int genreId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, a.name as author_name, g.name as genre_name " +
                     "FROM books b " +
                     "LEFT JOIN authors a ON b.author_id = a.author_id " +
                     "LEFT JOIN genres g ON b.genre_id = g.genre_id " +
                     "WHERE b.status = 1 AND b.genre_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, genreId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                books.add(extractBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    public Book getBookById(int bookId) {
        String sql = "SELECT b.*, a.name as author_name, g.name as genre_name " +
                     "FROM books b " +
                     "LEFT JOIN authors a ON b.author_id = a.author_id " +
                     "LEFT JOIN genres g ON b.genre_id = g.genre_id " +
                     "WHERE b.book_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractBook(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Book> getAllBooksForAdmin() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, a.name as author_name, g.name as genre_name " +
                     "FROM books b " +
                     "LEFT JOIN authors a ON b.author_id = a.author_id " +
                     "LEFT JOIN genres g ON b.genre_id = g.genre_id";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                books.add(extractBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    public boolean addBook(Book book) {
        String sql = "INSERT INTO books (title, price, description, author_id, genre_id, status, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, book.getTitle());
            ps.setDouble(2, book.getPrice());
            ps.setString(3, book.getDescription());
            ps.setInt(4, book.getAuthorId());
            ps.setInt(5, book.getGenreId());
            ps.setBoolean(6, book.isStatus());
            ps.setString(7, book.getImageUrl());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET title=?, price=?, description=?, author_id=?, genre_id=?, status=?, image_url=? WHERE book_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, book.getTitle());
            ps.setDouble(2, book.getPrice());
            ps.setString(3, book.getDescription());
            ps.setInt(4, book.getAuthorId());
            ps.setInt(5, book.getGenreId());
            ps.setBoolean(6, book.isStatus());
            ps.setString(7, book.getImageUrl());
            ps.setInt(8, book.getBookId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteBook(int bookId) {
        String sql = "DELETE FROM books WHERE book_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Book extractBook(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setBookId(rs.getInt("book_id"));
        book.setTitle(rs.getString("title"));
        book.setPrice(rs.getDouble("price"));
        book.setDescription(rs.getString("description"));
        book.setAuthorId(rs.getInt("author_id"));
        book.setGenreId(rs.getInt("genre_id"));
        book.setStatus(rs.getBoolean("status"));
        book.setImageUrl(rs.getString("image_url"));
        book.setAuthorName(rs.getString("author_name"));
        book.setGenreName(rs.getString("genre_name"));
        return book;
    }
}
