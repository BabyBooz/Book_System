package com.bookstore.model;

import java.util.Date;

public class Cart {
    private int cartId;
    private int userId;
    private Date createdAt;
    
    public Cart() {}
    
    public Cart(int cartId, int userId, Date createdAt) {
        this.cartId = cartId;
        this.userId = userId;
        this.createdAt = createdAt;
    }
    
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
