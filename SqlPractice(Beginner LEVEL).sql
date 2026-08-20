USE SalesDB
GO

SELECT *
FROM Sales.Customers

SELECT 
       CustomerID
      ,FirstName
      ,LastName
FROM Sales.Customers
WHERE "Country" = 'USA'  --Where Operators

--comparism operators of the Where operators --Tasks
SELECT *
FROM Sales.Customers
WHERE Score >=  500

--comparism operators of the Where operators --Tasks
SELECT *
FROM Sales.Customers
WHERE Score <=  500

--Logical operators of the Where operators --Tasks
SELECT *
FROM Sales.Customers
WHERE Country = 'USA' AND Score >  500 

--Logical operators of the Where operators --Tasks
SELECT *
FROM Sales.Customers
WHERE Not Score <  500 

--Logical operators of the Where operators --Tasks
SELECT *
FROM Sales.Customers
WHERE Country = 'USA' OR Score >  500 

--Range operators of the Where operators --Tasks
SELECT *
FROM Sales.Customers
WHERE Score >  100 AND Score < 500

--MEMBERSHIP operators of the Where operators --Tasks
SELECT *
FROM Sales.Customers
WHERE Country IN ('USA')

--MEMBERSHIP operators of the Where operators --Tasks
SELECT *
FROM Sales.Customers
WHERE Country NOT IN ('Germany')

--SEARCH operator of the Where operators --Tasks
SELECT *
FROM Sales.Customers
WHERE FirstName LIKE '%nn%'



--Joining DATA   /* DATA JOINS */
--# NO JOINS
SELECT *
FROM Sales.Customers ;
               -- This can display two tables without them joining tables
SELECT *
FROM Sales.Employees

--# FULL JOIN
SELECT *
FROM Sales.Customers AS c
FULL JOIN Sales.Orders AS o             -- This can display two tables by joining them
ON c.CustomerID = o.ProductID 

--# FULL JOIN
SELECT *
FROM Sales.Orders AS o
FULL JOIN Sales.Products AS p             -- This can display two tables by joining them
ON o.CustomerID = p.ProductID 

--# LEFT JOIN
SELECT *
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o             -- This can display two tables by Comparing one(Main Table) to the other(Left join)
ON c.CustomerID = o.ProductID 

--# RIGHT JOIN
SELECT *
FROM Sales.Customers AS c
RIGHT JOIN Sales.Orders AS o             -- This can display two tables by Comparing one(Right Join) to the other(Main Table)
ON c.CustomerID = o.ProductID 

/* ADVANCED JOINS */ 
--# LEFT ANTI-JOINS  #USEFUL AS Filters
SELECT *
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o             -- This can DIFF two tables by Comparing one(left Join) to the other(Main Table) which has no match
ON c.CustomerID = o.ProductID
WHERE o.ProductID IS NULL

--#RIGHT ANTI-JOIN 
SELECT *
FROM Sales.Orders AS o
RIGHT JOIN Sales.Customers AS c            -- This can diff two tables by Comparing one(Right Join) to the other(Main Table) which has no match
ON o.ProductID = c.CustomerID
WHERE o.CustomerID IS NULL

--#FULL ANTI-JOIN 
SELECT *
FROM Sales.Orders AS o
FULL JOIN Sales.Customers AS c            -- This can diff two tables by Comparing one(Right Join) to the other(Main Table) which has no match from both
ON o.ProductID = c.CustomerID 
WHERE c.CustomerID IS NULL

--#FULL ANTI-JOIN 
SELECT *
FROM Sales.Orders AS o
FULL JOIN Sales.Customers AS c            -- This can diff two tables by Comparing one(Right Join) to the other(Main Table) which has no match from both
ON o.ProductID = c.CustomerID 
WHERE o.CustomerID IS NOT  NULL

--#CROSS-JOIN 
SELECT *
FROM Sales.Orders AS o
CROSS JOIN Sales.Customers AS c            -- This cOMBINES all the rows from right with those from the left

--MULTIPLE JOINS
/*
SELECT 
   *
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c            -- This can diff two tables by Comparing one(Right Join) to the other(Main Table) which has no match from both
LEFT JOIN Sales.Employees AS e
LEFT JOIN Sales.OrdersArchive AS a : */

--SET OPERATORS
--#UNION 
SELECT        --Employees AS Source-Table
       EmployeeID
      ,LastName
      ,Department
      ,Gender
      ,Salary
FROM Sales.Employees
UNION                           -- THIS JOINS two tables  without duplicates
SELECT 
       CustomerID
      ,FirstName
      ,LastName
      ,Country
      ,Score
FROM Sales.Customers

--#UNION ALL
SELECT        --Employees AS Source-Table
       EmployeeID
      ,LastName
      ,Department
      ,Gender
      ,Salary
FROM Sales.Employees
UNION ALL                         --Joins BOth TABLES With duplicates
SELECT 
       CustomerID
      ,FirstName
      ,LastName
      ,Country
      ,Score
FROM Sales.Customers


--#EXCEPT
SELECT     --Employees AS Source-Table
       EmployeeID
      ,LastName
      ,Department
      ,Gender
      ,Salary
FROM Sales.Employees
EXCEPT                         --Joins BOth TABLES With duplicates but from first table only
SELECT 
       CustomerID
      ,FirstName
      ,LastName
      ,Country
      ,Score
FROM Sales.Customers

--#INTERSECT
SELECT         --Customers AS Source-Table
       CustomerID
      ,FirstName
      ,LastName
      ,Country
      ,Score
FROM Sales.Customers
INTERSECT                         --Joins BOth TABLES Without duplicates but commons from both columns
SELECT 
       EmployeeID
      ,LastName
      ,Department
      ,Gender
      ,Salary
FROM Sales.Employees



--#COMBINING ALL ORDERS INTO ONE WITHOUT DUPLICATES
SELECT   --#Orders.Archive As Source-Table
      [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM  Sales.OrdersArchive 
UNION
SELECT 
         [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders      
