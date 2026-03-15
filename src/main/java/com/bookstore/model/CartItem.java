package com.bookstore.model;

public class CartItem {
    private int cartItemId;
    private int cartId;
    private int bookId;
    private int quantity;
    private double totalPrice;
    private Book book;
    
    public CartItem() {}
    
    public CartItem(int cartItemId, int cartId, int bookId, int quantity, double totalPrice) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }
    
    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }
    
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }
    
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    
    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
}
