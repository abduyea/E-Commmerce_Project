-- Create the database
DROP DATABASE IF EXISTS ECommerceDB;
CREATE DATABASE IF NOT EXISTS ECommerceDB;
USE ECommerceDB;
-- Create User table

CREATE TABLE IF NOT EXISTS Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    RegistrationDate DATE NOT NULL
);

-- Create Customer table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT UNIQUE NOT NULL,
    Address VARCHAR(255) NOT NULL,
    FOREIGN KEY (UserID)
        REFERENCES Users (UserID)
        ON DELETE CASCADE
);

-- Create Product table
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Category ENUM('Electronics', 'Clothing', 'Home', 'Books', 'Other'),
    CostPrice DECIMAL(10 , 2 ) NOT NULL,
    RetailPrice DECIMAL(10 , 2 ) NOT NULL,
    StockQuantity INT NOT NULL CHECK (StockQuantity >= 0),
    is_discontinued BOOLEAN DEFAULT FALSE
);

-- Create Order table
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    OrderStatus ENUM('Cancelled','Unpaid','Paid','Shipped','Fulfilled') NOT NULL DEFAULT 'Unpaid',
    FOREIGN KEY (CustomerID)
        REFERENCES Customers (CustomerID)
        ON DELETE CASCADE
);

-- Create Payment table
CREATE TABLE IF NOT EXISTS Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentAmount DECIMAL(10 , 2 ) NOT NULL,
    PaymentDate DATETIME NOT NULL,
    FOREIGN KEY (OrderID)
        REFERENCES Orders (OrderID)
        ON DELETE CASCADE
);

-- Create LineItem table
CREATE TABLE IF NOT EXISTS LineItems (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    LinePrice DECIMAL(10 , 2 ) NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    PRIMARY KEY (OrderID , ProductID),
    FOREIGN KEY (OrderID)
        REFERENCES Orders (OrderID)
        ON DELETE CASCADE,
    FOREIGN KEY (ProductID)
        REFERENCES Products (ProductID)
        ON DELETE CASCADE
);

-- Create Review table
CREATE TABLE IF NOT EXISTS Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    OrderID INT,
    ProductID INT NOT NULL,
    Rating FLOAT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (UserID)
        REFERENCES Users (UserID)
        ON DELETE CASCADE,
    FOREIGN KEY (OrderID)
        REFERENCES Orders (OrderID)
        ON DELETE SET NULL,
    FOREIGN KEY (ProductID)
        REFERENCES Products (ProductID)
        ON DELETE CASCADE
);

-- Insert sample users
INSERT INTO Users (Email, Username, PasswordHash, RegistrationDate) VALUES
('abebe.kebede@gmail.com', 'abebe_kebede', '23w4g56gwesnrt6756e45', '2020-03-12'),
('mekdes.tsegaye@yahoo.com', 'mekdes_tsegaye', 'b23452345gbwetb', '2021-07-24'),
('getachew.mulu@gmail.com', 'getachew_mulu', 'bw45bwe45w423b52', '2022-01-15'),
('ayele.debebe@gmail.com', 'ayele_debebe', 'b3456weebrtbt2wb', '2023-05-06'),
('tsehay.yilma@yahoo.com', 'tsehay_yilma', '84n5e67en34q5n8en6', '2024-09-30'),
('emily.smith@gmail.com', 'emily_smith', 'm06olree5b4we4nyrmetem', '2021-02-10'),
('michael.johnson@yahoo.com', 'michael_johnson', '895567me6dh556eg3465', '2022-04-22'),
('sarah.jones@gmail.com', 'sarah_jones', '34567j7357etnydr5648er57', '2020-11-05'),
('william.brown@yahoo.com', 'william_brown', '3457e576ne6ffd65g38534', '2023-08-19'),
('jessica.miller@gmail.com', 'jessica_miller', 'd56md5r7m58354673n667r8', '2024-03-27');

-- Insert sample customers
INSERT INTO Customers (UserID, Address) VALUES
(1, '123 Rainier Ave, Seattle, WA'),
(2, '456 Peachtree St, Atlanta, GA'),
(3, '789 Michigan Ave, Chicago, IL'),
(4, '321 Lombard St, San Francisco, CA'),
(5, '654 Walnut St, Philadelphia, PA'),
(6, '987 Congress Ave, Austin, TX'),
(7, '135 Tremont St, Boston, MA'),
(8, '246 Ocean Blvd, Miami, FL'),
(9, '369 Summit Ave, St. Paul, MN'),
(10, '482 Broadway, New York, NY');

-- Insert sample products
INSERT INTO Products (ProductName, Description, Category, CostPrice, RetailPrice, StockQuantity) VALUES
('Smartphone X', 'Latest smartphone with advanced features', 'Electronics', 500.00, 799.99, 50),
('Laptop Pro', 'High-performance laptop for professionals', 'Electronics', 800.00, 1299.99, 30),
('Wireless Headphones', 'Noise-cancelling wireless headphones', 'Electronics', 100.00, 199.99, 100),
('Cotton T-Shirt', 'Comfortable 100% cotton t-shirt', 'Clothing', 5.00, 19.99, 200),
('Jeans', 'Classic blue jeans', 'Clothing', 20.00, 59.99, 150),
('Coffee Table', 'Modern wooden coffee table', 'Home', 50.00, 149.99, 25),
('Throw Pillow', 'Soft decorative throw pillow', 'Home', 8.00, 24.99, 75),
('Bestseller Novel', 'New York Times bestseller', 'Books', 10.00, 24.99, 120),
('Cookbook', 'Collection of gourmet recipes', 'Books', 15.00, 29.99, 80),
('Smart Watch', 'Fitness tracking smart watch', 'Electronics', 120.00, 249.99, 60);

-- Insert sample orders
INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2023-11-01 10:15:00'),
(2, '2023-11-02 14:30:00'),
(3, '2023-11-03 09:45:00'),
(4, '2023-11-04 16:20:00'),
(5, '2023-11-05 11:10:00'),
(6, '2023-11-06 13:25:00'),
(7, '2023-11-07 15:40:00'),
(8, '2023-11-08 12:55:00'),
(9, '2023-11-09 10:05:00'),
(10, '2023-11-10 14:15:00');

-- Insert sample payments 
INSERT INTO Payments (OrderID, PaymentAmount, PaymentDate) VALUES
(1, 799.99, '2023-11-01 10:20:00'),
(2, 1299.99, '2023-11-02 14:35:00'),
(3, 199.99, '2023-11-03 09:50:00'),
(4, 59.99, '2023-11-04 16:25:00'),
(5, 149.99, '2023-11-05 11:15:00'),
(6, 24.99, '2023-11-06 13:30:00'),
(7, 24.99, '2023-11-07 15:45:00'),
(8, 29.99, '2023-11-08 13:00:00'),
(9, 249.99, '2023-11-09 10:10:00'),
(10, 199.99, '2023-11-10 14:20:00');

-- Insert sample line items 
INSERT INTO LineItems (OrderID, ProductID, LinePrice, Quantity) VALUES
(1, 1, 799.99, 2),
(2, 2, 1299.99, 1),
(3, 3, 199.99, 3),
(4, 5, 59.99, 5),
(5, 6, 149.99, 2),
(6, 7, 24.99, 4),
(7, 8, 24.99, 1),
(8, 9, 29.99, 6),
(9, 10, 249.99, 2),
(10, 3, 199.99, 7);

-- Insert sample reviews 
INSERT INTO Reviews (UserID, OrderID, ProductID, Rating, ReviewText, ReviewDate) VALUES
(1, 1, 1, 5, 'Excellent phone with great features!', '2023-11-05'),
(2, 2, 2, 4, 'Fast performance but battery could be better', '2023-11-06'),
(3, 3, 3, 5, 'Amazing sound quality!', '2023-11-07'),
(4, 4, 5, 3, 'Good jeans but ran a bit large', '2023-11-08'),
(5, 5, 6, 4, 'Nice table, easy to assemble', '2023-11-09'),
(6, 6, 7, 5, 'Very comfortable pillow', '2023-11-10'),
(7, 7, 8, 4, 'Great book, couldn''t put it down', '2023-11-11'),
(8, 8, 9, 3, 'Good recipes but some ingredients hard to find', '2023-11-12'),
(1, 9, 10, 5, 'Love this smart watch!', '2023-11-13'),
(2, 10, 3, 4, 'Good headphones but a bit pricey', '2023-11-14');

-- 1. List products currently in inventory
SELECT 
    ProductID, ProductName, StockQuantity
FROM
    Products
WHERE
    StockQuantity > 0
ORDER BY ProductName;

-- 2. Create new product
INSERT INTO Products (ProductName, Description, Category, CostPrice, RetailPrice, StockQuantity) 
VALUES ('Bluetooth Speaker', 'Portable wireless speaker with high-fidelity sound', 'Electronics', 25.00, 59.99, 40);

-- 3. Modify product inventory amount
UPDATE Products 
SET 
    StockQuantity = 75
WHERE
    ProductID = 1;

-- 4. Delete a product from inventory
DELETE FROM Products 
WHERE
    ProductID = 10;

-- 5. Most popular products for a time range
SELECT 
    p.ProductID, p.ProductName, SUM(li.Quantity) AS TotalSold
FROM
    Products p
        JOIN LineItems li 
			ON p.ProductID = li.ProductID
        JOIN Payments t 
			ON li.OrderID = t.OrderID
        JOIN Orders o 
			ON t.OrderID = o.OrderID
WHERE
    o.OrderDate BETWEEN '2023-11-01' AND '2023-11-30'
GROUP BY p.ProductID , p.ProductName
ORDER BY TotalSold DESC
LIMIT 5;

-- 6. Least popular products for a time range
SELECT 
    p.ProductID,
    p.ProductName,
    COALESCE(SUM(li.Quantity), 0) AS TotalSold
FROM
    Products p
        LEFT JOIN LineItems li
			ON p.ProductID = li.ProductID
        LEFT JOIN Orders o
			ON li.OrderID = o.OrderID
        AND o.OrderDate BETWEEN '2023-11-01' AND '2023-11-30'
GROUP BY p.ProductID , p.ProductName
ORDER BY TotalSold ASC
LIMIT 5;

-- 7. Inactive users for promotional emails
SELECT 
    u.UserID,
    u.Email,
    u.Username,
    MAX(o.OrderDate) AS LastPurchaseDate
FROM
    Users u
        JOIN Customers c
			ON u.UserID = c.UserID
        LEFT JOIN Orders o
			ON c.CustomerID = o.CustomerID
GROUP BY u.UserID , u.Email , u.Username
HAVING LastPurchaseDate IS NULL
    OR LastPurchaseDate < DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
ORDER BY LastPurchaseDate;

-- 7a.  products users normally purchase 
WITH InactiveUsers AS (
    SELECT u.UserID, c.CustomerID
    FROM Users u
    JOIN Customers c 
		ON u.UserID = c.UserID
    LEFT JOIN Orders o 
		ON c.CustomerID = o.CustomerID
    GROUP BY u.UserID, c.CustomerID
    HAVING MAX(o.OrderDate) IS NULL OR MAX(o.OrderDate) < DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
)
SELECT iu.UserID, p.ProductID, p.ProductName, COUNT(*) AS PurchaseCount
FROM InactiveUsers iu
JOIN Orders o 
	ON iu.CustomerID = o.CustomerID
JOIN LineItems li 
	ON li.OrderID = li.OrderID
JOIN Products p 
	ON li.ProductID = p.ProductID
WHERE o.OrderDate < DATE_SUB(CURDATE(), INTERVAL 3 MONTH) -- only *historical* purchasescustomersCustomerID
GROUP BY iu.UserID, p.ProductID, p.ProductName
ORDER BY iu.UserID, PurchaseCount DESC;

