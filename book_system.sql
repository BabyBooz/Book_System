-- Tạo cơ sở dữ liệu
CREATE DATABASE bookstore_system;
USE bookstore_system;

-- Tạo bảng `users`
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    roll_number VARCHAR(50) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    address TEXT,
    role VARCHAR(10) CHECK (role IN ('customer', 'admin')) NOT NULL
);
GO

-- Tạo bảng `authors`
CREATE TABLE authors (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
GO

-- Tạo bảng `genres`
CREATE TABLE genres (
    genre_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
GO

-- Tạo bảng `books`
CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    author_id INT,
    genre_id INT,
    status BIT NOT NULL,  -- Sử dụng BIT cho trạng thái (1: hiển thị, 0: không hiển thị)
    image_url VARCHAR(255),
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);
GO

-- Tạo bảng `cart`
CREATE TABLE cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

-- Tạo bảng `cart_items`
CREATE TABLE cart_items (
    cart_item_id INT IDENTITY(1,1) PRIMARY KEY,
    cart_id INT,
    book_id INT,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
GO

-- Tạo bảng `orders`
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(10) CHECK (status IN ('wait', 'process', 'done')) NOT NULL DEFAULT 'wait',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
GO

-- Tạo bảng `order_items`
CREATE TABLE order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
GO

USE bookstore_system;
GO

-- 1. Thêm dữ liệu vào bảng users
INSERT INTO users (roll_number, full_name, username, password, email, phone, address, role) 
VALUES
('ADMIN001', N'Nguyễn Văn Quản Trị', 'admin', 'hashed_password_1', 'admin@bookstore.com', '0901234567', N'Hà Nội', 'admin'),
('CUST001', N'Trần Thị Khách Hàng', 'khachhang1', 'hashed_password_2', 'khachhang1@gmail.com', '0987654321', N'Hồ Chí Minh', 'customer'),
('CUST002', N'Lê Văn Mua Sắm', 'khachhang2', 'hashed_password_3', 'khachhang2@gmail.com', '0911222333', N'Đà Nẵng', 'customer');
GO

-- 2. Thêm dữ liệu vào bảng authors
INSERT INTO authors (name) 
VALUES
(N'Nam Cao'),
(N'J.K. Rowling'),
(N'George Orwell');
GO

-- 3. Thêm dữ liệu vào bảng genres
INSERT INTO genres (name) 
VALUES
(N'Văn học Việt Nam'),
(N'Fantasy (Kỳ ảo)'),
(N'Khoa học viễn tưởng');
GO

-- 4. Thêm dữ liệu vào bảng books (Khớp với author_id và genre_id ở trên)
INSERT INTO books (title, price, description, author_id, genre_id, status, image_url) 
VALUES
(N'Chí Phèo', 50000.00, N'Tác phẩm văn học hiện thực phê phán kinh điển của Nam Cao.', 1, 1, 1, 'chipheo.jpg'),
(N'Harry Potter và Hòn đá Phù thủy', 120000.00, N'Tập 1 của series phép thuật nổi tiếng thế giới.', 2, 2, 1, 'hp_tap1.jpg'),
(N'1984', 95000.00, N'Tiểu thuyết viễn tưởng về một xã hội bị kiểm soát hoàn toàn.', 3, 3, 1, '1984_book.jpg');
GO

-- 5. Thêm dữ liệu vào bảng cart (Tạo giỏ hàng cho user 2 và 3)
INSERT INTO cart (user_id) 
VALUES
(2), -- Giỏ hàng của CUST001
(3); -- Giỏ hàng của CUST002
GO

-- 6. Thêm dữ liệu vào bảng cart_items 
-- (CUST001 thêm 1 cuốn Harry Potter và 2 cuốn 1984 vào giỏ)
INSERT INTO cart_items (cart_id, book_id, quantity, total_price) 
VALUES
(1, 2, 1, 120000.00), -- 1 x 120,000
(1, 3, 2, 190000.00); -- 2 x 95,000
GO

-- 7. Thêm dữ liệu vào bảng orders (CUST002 đặt một đơn hàng)
INSERT INTO orders (user_id, total_price, status) 
VALUES
(3, 100000.00, 'wait'); -- Tổng đơn 100k, trạng thái đang chờ
GO

-- 8. Thêm dữ liệu vào bảng order_items (Chi tiết đơn hàng của CUST002: mua 2 cuốn Chí Phèo)
INSERT INTO order_items (order_id, book_id, quantity, price, total_price) 
VALUES
(1, 1, 2, 50000.00, 100000.00);
GO