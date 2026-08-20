USE SalesDB 
GO

 ---/*  CTES🔆 */   ---
                                               --🔅---NON-RECURSIVE CTES;
    --🔅STANDALONE CTES In Action

/*🤖STEP 1    Task 1.1 :  Finding the Total Sales per Customer  */
---Stand-Alone CTE Build-Up
WITH CTE_Total_Sales AS (
SELECT 
    CustomerID
   ,SUM(Sales) [Total sales]
FROM Sales.Orders 
GROUP BY CustomerID
)
---Main Query Model
SELECT 
        c.CustomerID
       ,CONCAT(FirstName , ' ', LastName) [Full Name]
       ,cts.[Total sales]
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON c.CustomerID = cts.CustomerID


       --🔅---NON-RECURSIVE CTES;
                --🔅MULTIPLE STANDALONE CTES In Action

/*🤖STEP 2   Task 1.1 :  Finding the Last Order-Date For Each Customer  */
---Stand Alone CTE Build-Up
WITH CTE_Last_Order As 
(
SELECT 
        CustomerID
       ,MAX(OrderDate) [Last Order Date]
FROM Sales.Orders 
GROUP BY CustomerID
)
  /*🤖STEP 3   Task 1.1 :  Ranking Customers Based On Total Sales Per Customer  */
  ---StandAlone CTE Build-Up
,CTE_Customer_Rank As
(
SELECT 
        CustomerID
       ,SUM(Sales) [Total Sales]
       ,RANK() OVER(ORDER BY SUM(Sales) DESC) [Customer Rank]
FROM Sales.Orders 
GROUP BY CustomerID
)
---Main Query Model
SELECT 
        c.CustomerID
       ,CONCAT(FirstName , ' ', LastName) [Full Name]
       ,clo.[Last Order Date]
       ,ctr.[Customer Rank]
FROM Sales.Customers c
LEFT JOIN CTE_Last_Order clo
ON c.CustomerID = clo.CustomerID
LEFT JOIN CTE_Customer_Rank ctr 
ON c.CustomerID = ctr.CustomerID



---StandAlone   CTE BuildUp
WITH CTE_Total_Sales AS (
SELECT 
    CustomerID
   ,SUM(Sales) [Total sales]
FROM Sales.Orders 
GROUP BY CustomerID
)
--🔅---NON-RECURSIVE CTES;
                --🔅NESTED CTES In Action   --A Type of CTE That works Leeching Off Another CTE.
  /*🤖STEP 4   Task 1.1 :  Segmenting Customers Based on Their Total Sales */
  ---Nested CTE Build-Up
,CTE_Customer_Segment As 
(
SELECT 
        CustomerID
       ,[Total Sales]
,CASE  WHEN  [Total Sales] > 100
                      THEN 'High'
         WHEN [Total Sales] > 80
                     THEN 'Medium'
        ELSE 'Low'
END Cst_Segment
FROM CTE_Total_Sales 
)
---Main Query Model
SELECT 
        c.CustomerID
       ,CONCAT(FirstName , ' ', LastName) [Full Name]
       ,cts.[Total sales]
       ,ccs.Cst_Segment
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON c.CustomerID = cts.CustomerID
LEFT JOIN CTE_Customer_Segment ccs
ON c.CustomerID = ccs.CustomerID


   ---🔅RECURSIVE CTES In Action   --Much Like A loop : It queries repeatedly until a specific conditon is met
     ---Can Be Used In HIERARCHY Structures

/*Task 1.1 :  Generating a Sequence Of Numbers From 1 to 20 */

WITH Series As 
(
  ---Anchor Query
SELECT 1 As My_Number
UNION ALL
--- Recursive CTE query
SELECT My_Number +1
FROM Series
WHERE My_Number < 200
)
---Main Query
SELECT *
FROM  Series
OPTION (MAXRECURSION 1000)  --To Ctrl The Recursion LIMITATION Of 100

/*Task 1.1 :  Showing The Employee Hierarchy By Displaying 
                                                          Each Employees Level Within The Organisation */

 ---Recursive Query Build-Up                                                         
WITH CTE_Employee_Hierarchy As 
(
-- Anchor Query
SELECT 
           [EmployeeID]
          ,[FirstName]
          ,[ManagerID] , 
          1 As Level
FROM Sales.Employees
WHERE ManagerID IS NULL

UNION ALL 
   ---Recursive CTE_Query
SELECT 
            e.[EmployeeID]
           ,e.[FirstName]
          ,e.[ManagerID]
          ,ceh.Level + 1
FROM Sales.Employees e
INNER JOIN CTE_Employee_Hierarchy ceh 
ON e.ManagerID = ceh.EmployeeID
)
---Main Query Model
SELECT *
FROM CTE_Employee_Hierarchy






   --🔅---VIEWS ;
                --🔅VIEWS In Action         
      ---#1  USAGE:  #Reducing Redundancies 
      ---##TASK:Finding the Running Total Of Sales For Each Month
---🤖 Step 1:   

/*    WITH CTE_Monthly_Summary as
( 
---Anchor CTE Query Build-Up
SELECT 
DATETRUNC(MONTH , OrderDate) [Order Month]
,SUM(Sales) [Total Sales]
,COUNT(OrderID)  [Total Orders]
,SUM(Quantity)  [Total Quantity]
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH , OrderDate) 
)
---MAIN QUERY MODEL
SELECT 
[Order Month]
,[Total Quantity]
,[Total Sales]
,SUM([Total Sales]) OVER (ORDER BY [Order Month]) [Running Total]
FROM CTE_Monthly_Summary      

*/

---🤖 Step 2: pUtting the CTE Query In VIEW 
CREATE VIEW Sales.CTE_Monthly_Summary As
(
---VIEW Query Build-Up
SELECT 
DATETRUNC(MONTH , OrderDate) [Order Month]
,SUM(Sales) [Total Sales]
,COUNT(OrderID)  [Total Orders]
,SUM(Quantity)  [Total Quantity]
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH , OrderDate) 
)

---🤖 Step 3: pUtting the View Query To Work
---MAIN QUERY MODEL
SELECT 
[Order Month]
,[Total Quantity]
,[Total Sales]
,SUM([Total Sales]) OVER (ORDER BY [Order Month]) [Running Total]
FROM Sales.CTE_Monthly_Summary 

---🤖 Step 4: Make Sure  the View Query Is in Right SCHEMA

---🤖 Step 5: Removing Unnecessary VIEWS 

DROP VIEW dbo.CTE_Monthly_Summary

---🤖 Step 6: Updating An EXISTING VIEW ;Adding Or Removing
--DROP VIEW
--Then Recreate THE VIEW With UNeccessary Changes


----OR  T-SQL
IF OBJECT_ID('Sales.Monthly_Summary','V') IS NOT NULL
DROP VIEW Sales.Monthly_Summary;
GO
CREATE VIEW Sales.Monthly_Summary As
(
SELECT 
DATETRUNC(MONTH , OrderDate) [Order Month]
,SUM(Sales) [Total Sales]
,COUNT(OrderID)  [Total Orders]
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH , OrderDate)
)
  


     ---#2  USAGE:  #Reducing/Hiding Complexities of DB Tables
      ---##TASK:Providing A View That Combines Details From ORDERS ,PRODUCTS, CUSTOMER, And EMPLOYEES

---🤖 Step 1:   Query Build-Up to Use In The View

SELECT 
o.OrderID
,o.OrderDate
,p.Product
,p.Category
,COALESCE(c.FirstName, ' ') + ' ' +COALESCE(c.LastName, ' ') [Customer Name]
,c.Country [Customer Country]
,COALESCE(e.FirstName, ' ') + ' ' +COALESCE(e.LastName, ' ') [Employees Name]
,e.Department
,o.Sales ,o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales.Products p
ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID

---🤖 Step 2:  Putting The Query In View Model
CREATE VIEW Sales.View_Order_Details As
(
SELECT 
o.OrderID
,o.OrderDate
,p.Product
,p.Category
,COALESCE(c.FirstName, ' ') + ' ' +COALESCE(c.LastName, ' ') [Customer Name]
,c.Country [Customer Country]
,COALESCE(e.FirstName, ' ') + ' ' +COALESCE(e.LastName, ' ') [Employees Name]
,e.Department
,o.Sales ,o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales.Products p
ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID
)

---🤖 Step 3:  Putting The Query To Work
SELECT 
OrderID
,OrderDate
,[Customer Name]
,[Customer Country]
,Sales
FROM Sales.View_Order_Details


---#3  USAGE:  #Data Security/Security of DB Tables
      ---##TASK:Providing A View That Combines Details From All Tables AND Excludes Data Related To the USA

---🤖 Step 1:   Query Build-Up to Use In The View

SELECT 
o.OrderID
,o.OrderDate
,p.Product
,p.Category
,COALESCE(c.FirstName, ' ') + ' ' +COALESCE(c.LastName, ' ') [Customer Name]
,c.Country [Customer Country]
,COALESCE(e.FirstName, ' ') + ' ' +COALESCE(e.LastName, ' ') [Employees Name]
,e.Department
,o.Sales ,o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales.Products p
ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID

---🤖 Step 2:   Putting Query In View Model
CREATE VIEW Sales.All_Orders_Details_EU As
(
SELECT 
o.OrderID
,o.OrderDate
,p.Product
,p.Category
,COALESCE(c.FirstName, ' ') + ' ' +COALESCE(c.LastName, ' ') [Customer Name]
,c.Country [Customer Country]
,COALESCE(e.FirstName, ' ') + ' ' +COALESCE(e.LastName, ' ') [Employees Name]
,e.Department
,o.Sales ,o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales.Products p
ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID
WHERE c.Country != 'USA'
)

---🤖 Step 3:  Putting The Query To Work
SELECT *
FROM Sales.All_Orders_Details_EU