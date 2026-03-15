package com.bookstore.servlet;

import com.bookstore.dao.CartDAO;
import com.bookstore.dao.OrderDAO;
import com.bookstore.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();
    private OrderDAO orderDAO = new OrderDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Cart cart = cartDAO.getCartByUserId(user.getUserId());
        if (cart == null) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        List<CartItem> cartItems = cartDAO.getCartItems(cart.getCartId());
        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        double totalPrice = cartItems.stream()
                .mapToDouble(CartItem::getTotalPrice)
                .sum();
        
        int orderId = orderDAO.createOrder(user.getUserId(), totalPrice);
        
        if (orderId > 0) {
            for (CartItem item : cartItems) {
                orderDAO.addOrderItem(orderId, item.getBookId(), item.getQuantity(), 
                        item.getBook().getPrice(), item.getTotalPrice());
            }
            
            cartDAO.clearCart(cart.getCartId());
            
            request.setAttribute("success", "Đặt hàng thành công! Mã đơn hàng: " + orderId);
            request.getRequestDispatcher("/client/checkout-success.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Đặt hàng thất bại!");
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}
