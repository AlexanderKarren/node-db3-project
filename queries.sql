-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
SELECT Product.ProductName, Category.CategoryName FROM [Product]
JOIN Category ON Product.CategoryId = Category.Id;

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.
SELECT Orders.Id, Shipper.CompanyName, Orders.OrderDate FROM Orders
JOIN Shipper on Orders.ShipVia = Shipper.Id
where date(Orders.OrderDate ) < date('2012-08-09');
-- * I had to change the name of the Order table to Orders because "Order" was conflicting with SQL Logic in my database browser *

-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
SELECT Product.ProductName, Product.QuantityPerUnit from OrderDetail
JOIN Product on OrderDetail.ProductId = Product.Id
where OrderDetail.OrderId = '10251';

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
 SELECT Orders.Id as 'Order ID'
, Customer.CompanyName as 'Customer Company'
, Employee.LastName as 'Employee Last Name'
FROM Orders
JOIN Customer ON Orders.CustomerId = Customer.Id
JOIN Employee ON Orders.EmployeeId = Employee.Id;

-- STRETCH: Displays CategoryName and a new column called Count that shows how many products are in each category. Shows 8 records.
SELECT CategoryName, COUNT(*) as total 
FROM [Products]
JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY Products.CategoryID;

-- STRETCH: Display OrderID and a column called ItemCount that shows the total number of products placed on the order. Shows 196 records.
SELECT OrderDetails.OrderID, COUNT(Products.ProductID) as 'Item Count'
FROM [Orders]
JOIN Products ON OrderDetails.ProductID = Products.ProductID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Orders.OrderID;