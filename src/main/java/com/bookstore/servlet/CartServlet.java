package com.bookstore.servlet;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CartDAO;
import com.bookstore.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();
    private BookDAO bookDAO = new BookDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Cart cart = cartDAO.getCartByUserId(user.getUserId());
        if (cart == null) {
            int cartId = cartDAO.createCart(user.getUserId());
            cart = new Cart();
            cart.setCartId(cartId);
            cart.setUserId(user.getUserId());
        }
        
        List<CartItem> cartItems = cartDAO.getCartItems(cart.getCartId());
        double totalAmount = cartItems.stream()
                .mapToDouble(CartItem::getTotalPrice)
                .sum();
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("/client/cart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            Book book = bookDAO.getBookById(bookId);
            
            Cart cart = cartDAO.getCartByUserId(user.getUserId());
            if (cart == null) {
                int cartId = cartDAO.createCart(user.getUserId());
                cart = new Cart();
                cart.setCartId(cartId);
            }
            
            cartDAO.addToCart(cart.getCartId(), bookId, 1, book.getPrice());
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } else if ("update".equals(action)) {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));
            double totalPrice = quantity * price;
            
            cartDAO.updateCartItem(cartItemId, quantity, totalPrice);
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } else if ("remove".equals(action)) {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            cartDAO.removeCartItem(cartItemId);
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } else if ("removeAll".equals(action)) {
            Cart cart = cartDAO.getCartByUserId(user.getUserId());
            if (cart != null) {
                cartDAO.clearCart(cart.getCartId());
            }
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}
