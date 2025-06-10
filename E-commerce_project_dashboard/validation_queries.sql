/***********************************************************************
E-Commerce Dashboard Validation Queries
 Abdulfeatah Adem and Krick


***********************************************************************/

/* 1. Products Currently in Inventory and Quantities */
SELECT 
    p.ProductID,
    p.ProductName,
    p.StockQuantity
FROM
    Products AS p
WHERE
    p.StockQuantity > 0
ORDER BY
    p.ProductName;

/* 2. Products with Low Stock Levels (Less than 10 units) */
SELECT 
    p.ProductID,
    p.ProductName,
    p.StockQuantity
FROM
    Products AS p
WHERE
    p.StockQuantity < 10
ORDER BY
    p.StockQuantity ASC;

/* 3. Top 10 Most Popular Products for a Given Date Range */
/* Sample date range used: 2025-01-01 to 2025-03-31 */
SELECT 
    li.ProductID,
    p.ProductName,
    SUM(li.Quantity) AS TotalQuantitySold
FROM
    LineItems li
    JOIN Orders o ON li.OrderID = o.OrderID
    JOIN Products p ON li.ProductID = p.ProductID
WHERE
    o.OrderDate BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY
    li.ProductID,
    p.ProductName
ORDER BY
    TotalQuantitySold DESC
LIMIT 10;

/* 4. Bottom 10 Least Popular Products for a Given Date Range */
/* Including products with zero sales */
SELECT 
    p.ProductID,
    p.ProductName,
    COALESCE(SUM(li.Quantity), 0) AS TotalQuantitySold
FROM
    Products p
    LEFT JOIN LineItems li ON p.ProductID = li.ProductID
    LEFT JOIN Orders o ON li.OrderID = o.OrderID
        AND o.OrderDate BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY
    TotalQuantitySold ASC
LIMIT 10;

/* 5. Users Who Have Not Made a Purchase in the Last X Months */
/* Sample interval: 6 months before current date */
SELECT 
    u.UserID,
    u.Username,
    MAX(o.OrderDate) AS LastPurchaseDate
FROM
    Users u
    LEFT JOIN Customers c ON u.UserID = c.UserID
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY
    u.UserID,
    u.Username
HAVING
    MAX(o.OrderDate) IS NULL
    OR MAX(o.OrderDate) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY
    LastPurchaseDate ASC;

/* 6. Typical Purchases by Users Inactive in the Last X Months */
/* Lists top 5 categories by purchase count */
SELECT 
    p.Category,
    COUNT(*) AS PurchaseCount
FROM
    Users u
    JOIN Customers c ON u.UserID = c.UserID
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN LineItems li ON o.OrderID = li.OrderID
    JOIN Products p ON li.ProductID = p.ProductID
WHERE
    u.UserID IN (
        SELECT 
            u2.UserID
        FROM
            Users u2
            LEFT JOIN Customers c2 ON u2.UserID = c2.UserID
            LEFT JOIN Orders o2 ON c2.CustomerID = o2.CustomerID
        GROUP BY
            u2.UserID
        HAVING
            MAX(o2.OrderDate) IS NULL
            OR MAX(o2.OrderDate) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    )
GROUP BY
    p.Category
ORDER BY
    PurchaseCount DESC
LIMIT 5;

/* 7. Newest Products */
/* Top 10 products ordered by creation date descending */
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.CreatedDate
FROM
    Products p
ORDER BY
    p.CreatedDate DESC
LIMIT 10;

/* 8. Best Performing Categories by Revenue and Units Sold */
/* For a given date range: 2025-01-01 to 2025-03-31 */
SELECT 
    p.Category,
    SUM(li.Quantity * li.LinePrice) AS TotalRevenue,
    SUM(li.Quantity) AS TotalUnitsSold
FROM
    LineItems li
    JOIN Orders o ON li.OrderID = o.OrderID
    JOIN Products p ON li.ProductID = p.ProductID
WHERE
    o.OrderDate BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY
    p.Category
ORDER BY
    TotalRevenue DESC;

/* Optional Extra: Number of Unique Customers per Category */
/* For the same date range */
SELECT 
    p.Category,
    COUNT(DISTINCT c.CustomerID) AS UniqueCustomers
FROM
    LineItems li
    JOIN Orders o ON li.OrderID = o.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN Products p ON li.ProductID = p.ProductID
WHERE
    o.OrderDate BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY
    p.Category
ORDER BY
    UniqueCustomers DESC;
