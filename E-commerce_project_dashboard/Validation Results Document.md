Validation Results Document 

SQL Query Results vs. Tableau Visualizations

1. Inventory: What products are currently in inventory, and how many of each?

SQL Query:

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

![1750188726046](image/ValidationResultsDocument/1750188726046.png)

2.  Which products have low stock levels?

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

![1750188797836](image/ValidationResultsDocument/1750188797836.png)


3. Most popular products for a given time range

SELECT
    li.ProductID,
    p.ProductName,
    SUM(li.Quantity) AS TotalQuantitySold
FROM
    LineItems AS li
    JOIN Orders AS o ON li.OrderID = o.OrderID
    JOIN Products AS p ON li.ProductID = p.ProductID
WHERE
    o.OrderDate BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY
    li.ProductID,
    p.ProductName
ORDER BY
    TotalQuantitySold DESC
LIMIT 10;
![1750188864027](image/ValidationResultsDocument/1750188864027.png)


4.  Least popular products for a given time range

SELECT
    p.ProductID,
    p.ProductName,
    COALESCE(SUM(li.Quantity), 0) AS TotalQuantitySold
FROM
    Products AS p
    LEFT JOIN LineItems AS li ON p.ProductID = li.ProductID
    LEFT JOIN Orders AS o ON li.OrderID = o.OrderID
       AND o.OrderDate BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY
    TotalQuantitySold ASC
LIMIT 10;
![1750188898328](image/ValidationResultsDocument/1750188898328.png)

5. Which users haven't made a purchase in the last X months?

SELECT
    u.UserID,
    u.Username,
    MAX(o.OrderDate) AS LastPurchaseDate
FROM
    Users AS u
    LEFT JOIN Customers AS c ON u.UserID = c.UserID
    LEFT JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY
    u.UserID,
    u.Username
HAVING
    (MAX(o.OrderDate) IS NULL OR MAX(o.OrderDate) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH))
ORDER BY
    LastPurchaseDate ASC;
![1750188951351](image/ValidationResultsDocument/1750188951351.png)
6. What do those users typically purchase?

SELECT
    p.Category,
    COUNT(*) AS PurchaseCount
FROM
    Users AS u
    JOIN Customers AS c ON u.UserID = c.UserID
    JOIN Orders AS o ON c.CustomerID = o.CustomerID
    JOIN LineItems AS li ON o.OrderID = li.OrderID
    JOIN Products AS p ON li.ProductID = p.ProductID
WHERE
    u.UserID IN (
        SELECT
            u2.UserID
        FROM
            Users AS u2
            LEFT JOIN Customers AS c2 ON u2.UserID = c2.UserID
            LEFT JOIN Orders AS o2 ON c2.CustomerID = o2.CustomerID
        GROUP BY
            u2.UserID
        HAVING
            (MAX(o2.OrderDate) IS NULL OR MAX(o2.OrderDate) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH))
    )
GROUP BY
    p.Category
ORDER BY
    PurchaseCount DESC
LIMIT 5;

![1750188978038](image/ValidationResultsDocument/1750188978038.png)
 7. What are our newest products?


SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    p.CreatedDate
FROM
    Products AS p
ORDER BY
    p.CreatedDate DESC
LIMIT 10;

![1750189044146](image/ValidationResultsDocument/1750189044146.png)
8. What categories are performing best?
SELECT
    p.Category,
    SUM(li.Quantity * li.LinePrice) AS TotalRevenue,
    SUM(li.Quantity) AS TotalUnitsSold
FROM
    LineItems AS li
    JOIN Orders AS o ON li.OrderID = o.OrderID
    JOIN Products AS p ON li.ProductID = p.ProductID
WHERE
    o.OrderDate BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY
    p.Category
ORDER BY
    TotalRevenue DESC;

![1750189073250](image/ValidationResultsDocument/1750189073250.png)