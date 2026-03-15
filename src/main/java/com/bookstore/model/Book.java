package com.bookstore.model;

public class Book {
    private int bookId;
    private String title;
    private double price;
    private String description;
    private int authorId;
    private int genreId;
    private boolean status;
    private String imageUrl;
    private String authorName;
    private String genreName;
    
    public Book() {}
    
    public Book(int bookId, String title, double price, String description, 
                int authorId, int genreId, boolean status, String imageUrl) {
        this.bookId = bookId;
        this.title = title;
        this.price = price;
        this.description = description;
        this.authorId = authorId;
        this.genreId = genreId;
        this.status = status;
        this.imageUrl = imageUrl;
    }
    
    // Getters and Setters
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public int getAuthorId() { return authorId; }
    public void setAuthorId(int authorId) { this.authorId = authorId; }
    
    public int getGenreId() { return genreId; }
    public void setGenreId(int genreId) { this.genreId = genreId; }
    
    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }
    
    public String getGenreName() { return genreName; }
    public void setGenreName(String genreName) { this.genreName = genreName; }
}
