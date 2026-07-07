--#AGGREGATE FN( ) & ANALYTICAL FN( )    --MAIN  🔆
                --#AGGREGATE FN( ) --#BRANCHED  🔅
--#COUNT FN ( )  --#SUM FN( )   --#MIN FN ( )   --#MAX FN( )  --#AVG FN ( )

--#SUM FN( ) --#CASE 1.0   TASK:  Finding total sales
SELECT 
          CustomerID
        ,CONCAT('$', SUM(Sales)) [Total_Sales]
FROM Sales.Orders
GROUP BY CustomerID
ORDER BY CustomerID  ASC

--#COUNT FN( )  --CASE 1.1   --#TASK:  Counting Total Orders
SELECT 
          CustomerID
          ,COUNT(*) [Total_Orders]
FROM Sales.Orders
GROUP BY CustomerID
ORDER BY CustomerID  ASC

 --#MIN FN() --CASE 1.2  --#
 SELECT 
          CustomerID
          ,MIN(Sales) as Minimum_Sales
FROM Sales.Orders
GROUP BY CustomerID
ORDER BY CustomerID  ASC




SELECT *
FROM Sales.Orders 