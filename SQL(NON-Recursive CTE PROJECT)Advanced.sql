USE SalesDB
GO
                                     --========================================================
                                                                              /*   CTE MINI PROJECT  */
                                     --========================================================

                                           --🔅---NON-RECURSIVE CTES;
    --🔅STANDALONE CTES In Action
--========================================================
/* STEP 1; Task 1.1 :  Finding the Total Sales per Customer  */
--========================================================
---Stand-Alone CTE Build-Up
WITH CTE_Total_Sales AS (
SELECT 
    CustomerID
   ,SUM(Sales) [Total sales]
FROM Sales.Orders 
GROUP BY CustomerID
)
--========================================================
/*STEP 2   Task 2.1 :  Finding the Last Order-Date For Each Customer  */
--========================================================
---Stand Alone CTE Build-Up
,CTE_Last_Order As 
(
SELECT 
        CustomerID
       ,MAX(OrderDate) [Last Order Date]
FROM Sales.Orders 
GROUP BY CustomerID
)
--========================================================
  /*STEP 3   Task 3.1 :  Ranking Customers Based On Total Sales Per Customer  */
--  ========================================================
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
--========================================================
             --🔅NESTED CTES In Action   --A Type of CTE That works BY Leeching Off Another CTE.
  /*STEP 4   Task 1.1 :  Segmenting Customers Based on Their Total Sales */
 -- ========================================================
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
--========================================================
---Main Query Model
--========================================================
SELECT 
        c.CustomerID
       ,CONCAT(FirstName , ' ', LastName) [Full Name]
       ,cts.[Total sales]
       ,clo.[Last Order Date]
       ,ccr.[Customer Rank]
       ,ccs.Cst_Segment
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON c.CustomerID = cts.CustomerID
LEFT JOIN CTE_Last_Order clo
ON c.CustomerID = clo.CustomerID
LEFT JOIN CTE_Customer_Rank ccr 
ON c.CustomerID = ccr.CustomerID
LEFT JOIN CTE_Customer_Segment ccs
ON c.CustomerID = ccs.CustomerID





  --========================================================

                                           --🔅RECURSIVE CTES  In Action

                                         --  ### Number Project
--========================================================


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