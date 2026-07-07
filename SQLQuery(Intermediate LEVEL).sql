

--#ROW-LEVEL FUNCTIONS( )   --#MAIN 

--#SINGLE ROW FUNCTION( )    --#BRANCH 🔅
                            --#STRING-FUNCTIONS( )   --#BRANCHED 🔀 🔆
             --#MANIPULATIONS FN( )
--#CONCAT
SELECT 
      CustomerID
      ,CONCAT(FirstName,' ',LastName,' ', 'From', ' ', Country) AS Full_Details
FROM Sales.Customers

--#UPPER( ) & LOWER( )
SELECT 
        CustomerID
        ,LOWER(FirstName) As Lo_first_name
        ,UPPER(LastName) As Up_name
FROM Sales.Customers

--# TRIM   --#To cut leading spaces
SELECT 
       CustomerID
       ,FirstName
       ,TRIM(FirstName) As Trim_FN
       ,LastName
       ,Country
FROM Sales.Customers
WHERE FirstName != TRIM(FirstName)

--#REPLACE
SELECT 'Saint0th@Gmail.Org' As Email_Address
,REPLACE('Saint0th@Gmail.Org', '.Org', '.Com') As Cleaned_Email
--#CASE 2
SELECT 'SQL_query_Code.Txt' As File_Name
,REPLACE('SQL_query_Code.Txt','Txt','Csv') As Correct_File_name

--#Calculation FN( ) 
--#LEN( )  --calculates lenght of value in any column
SELECT 
       CustomerID
       ,FirstName
       ,LEN(FirstName) As Len_FN
       ,LastName
       ,LEN(LastName) As Len_LN
       ,Country
FROM Sales.Customers

--#STRING EXTRACTION FN( )
        --#LEFT FN( )  & RIGHT FN( )
SELECT 
       CustomerID
       ,FirstName
       ,LEFT(FirstName,'3') As Nom_Extract   --#Extracts Chars from The start
       ,Country
FROM Sales.Customers

    --#RIGHT( )  --#Extracts Last CHARS From the Values
SELECT 
       CustomerID
       ,FirstName
       ,LEFT(FirstName,'3') As Nom_Extract
       ,LastName
       ,RIGHT(LastName,3) As Prenom_Extract
       ,Country
FROM Sales.Customers

--# SUBSTRING     --#extracts Chars from MIddle of the Values
SELECT 
       FirstName
       ,LEFT(FirstName,'3') As Nom_Extract  
       ,LastName
       ,SUBSTRING(LastName,2,3) As Middle_Extracts
       ,Country
FROM Sales.Customers


--#SINGLE ROW FUNCTION( )    --#BRANCH 🔅
            --#NUMERIC FUNCTION( )     --#BRANCHED 🔀 🔆
--#ABS( ) & ROUND( )
--#ROUND ( )
SELECT 3.4568 As _Value
,ROUND ('3.4568',2 ) As Round_value
,ROUND ('3.4568',3)  As Round_value1
,ROUND ('3.4568',1)  As Round_value2

--# ABS( )  --#Converts a Negative To Positives
SELECT -3.2  As Negative_Value
,ABS(-3.2) As Changed_Value

--#SINGLE ROW FUNCTION( )    --#BRANCH 🔅
            --#DATE AND TIME FN( )     --#BRANCHED 🔀 🔆
                        --#PART_EXTRACTION FN( )   --#BRANCHED 🔀 🔆
SELECT *
FROM Sales.OrdersArchive;

--#DAY FN( )
SELECT 
          OrderID
         ,OrderDate
         ,CreationTime
         ,CONCAT('Day',' ', DAY(CreationTime)) As Creation_Day
FROM Sales.Orders;

--#MONTH FN( )
SELECT 
          OrderID
         ,OrderDate
         ,CreationTime
         ,CONCAT('Month',' ', MONTH(CreationTime)) As Creation_Month
FROM Sales.Orders;

--#Case 1.1
--#All orders placed in Jan, Feb OR Mar
SELECT 
          OrderID
         ,OrderDate
         ,CreationTime
         ,CONCAT('Month',' ', MONTH(CreationTime)) As Creation_Month
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2

--#YEAR FN( )
SELECT 
          OrderID
         ,OrderDate
         ,CreationTime
         ,CONCAT('Year',' ', YEAR(CreationTime)) As Creation_Year
FROM Sales.Orders;

--#Case 1.0
--#All orders placed in a year
SELECT 
          OrderID
         ,OrderDate
         ,CreationTime
         ,CONCAT('Year',' ', YEAR(CreationTime)) As Creation_Month
FROM Sales.Orders
WHERE Year(OrderDate) = 2025


--#DATEPART FN( )    --#Extracts Part of a Date  
SELECT 
        OrderID
         ,OrderDate
         ,CONCAT('Quarter' , ' ', DATEPART(quarter,CreationTime)) As Quarter_Date  --#Case1.0
          ,CONCAT('Week' , ' ', DATEPART(WEEK,CreationTime)) As Week_Date           --#Case 1.1
FROM Sales.Orders

--#DATENAME FN( )
SELECT 
        OrderID
         ,OrderDate
         ,CONCAT('Quarter' , ' ', DATENAME(quarter,CreationTime)) As Quarter_Date  --#Case1.0
          ,CONCAT('Week' , ' ', DATENAME(WEEK,CreationTime)) As Week_Date           --#Case 1.1
          ,CONCAT('Day:' , ' ', DATENAME(Weekday,CreationTime)) As Days_Of_Week          --#Case 1.2
          ,CONCAT('Day' , ' ', DATENAME(DD,CreationTime)) As Day_Date           --#Case 1.3
FROM Sales.Orders

--#DATETRUNC FN ( )
SELECT 
        OrderID
         ,OrderDate
         ,CONCAT('Quarter' , ' ', DATETRUNC(quarter,CreationTime)) As Quarter_Date  --#Case1.0
          ,CONCAT('Week' , ' ', DATETRUNC(WEEK,CreationTime)) As Week_Date           --#Case 1.1
          ,CONCAT('Day' , ' ', DATETRUNC(DD,CreationTime)) As Day_Date           --#Case 1.3
FROM Sales.Orders

--#OR
--#Task: Finding How many orders did we receive in a year?
SELECT 
          CONCAT('Year' , ' ', DATETRUNC(YEAR,CreationTime)) As Day_Date           --#Case 1.0
         ,COUNT(*)   As Total_Year_Order
FROM Sales.Orders
GROUP BY  DATETRUNC(YEAR,CreationTime)

--#EOMONTH  --Changing Time to the end of the month
 SELECT  '23:22:04.0000000' As TIME_
 ,EOMONTH('23:22:04.0000000') As Time_Change



         --#DATE AND TIME FN( )     --#BRANCHED 🔀 🔆
                        --#FORMAT & CASTING FN( )   --#BRANCHED 🔀 🔆
--#FORMAT
--#TASK :  Show creation time using the fllwng format
--#Case 1.1
SELECT  
          OrderID
         ,CreationTime
        ,'Day:' + FORMAT(CreationTime,'ddd,mm') +' ' + 'Q' +DATENAME(Quarter,CreationTime) + ' ' + FORMAT(CreationTime,'yyyy hh:mm:ss tt') As Task_solved
FROM  Sales.Orders

--#Case 1.2
--#Task --#Show Order Dates AS Jan 25 & Order Count After it.
SELECT 
         FORMAT(OrderDate,'yyy MMM') As Format_Date
         ,COUNT(*)    As Order_Date

FROM Sales.Orders
GROUP BY  FORMAT(OrderDate,'yyy MMM')

--#CONVERT FN( )    --#Converts data-value to diff data type AND Format it e.g (Str to Int)
 SELECT '2025'  AS Str_Value
 ,CONVERT(INT,'2025') As Int_value  

 --#CAST FN( )    --#converts a value to a specific Data Type E.g (Str:'123' AS INT:123)
SELECT '123'  As Str_Value
,CAST('123' AS INT) As Casted


--#DATE AND TIME FN( )     --#BRANCHED 🔀 🔆
                        --#CALCULATION FN( )   --#BRANCHED 🔀 🔆
--#DATEADD fn( ) --#DATEDIFF FN( )

--#DATEADD( )   Adds and subtracts parts from a date
SELECT 
         OrderID
        ,CustomerID
        ,DATEADD(MONTH,-3,OrderDate) As Subtracted_Date   --#CASE 1.0
        ,DATEADD(YEAR,3,OrderDate) As Added_Year            --#CASE 1.1
        ,CreationTime
FROM  Sales.Orders

--#DATEDIFF( )
--#Case 1.0
SELECT 
         OrderID
        ,OrderDate As Current_Order_Date
        ,LAG(OrderDate) OVER(ORDER BY OrderDate) As Previous_Date
        ,DATEDIFF(Day,LAG(OrderDate) OVER(ORDER BY OrderDate),OrderDate) As No_Of_Days
FROM  Sales.Orders

--#Case 1.1
--#Task  CalculatING Age Of Employees
SELECT 
         EmployeeID
        ,CONCAT(FirstName,' ',LastName) As Full_Name
        ,BirthDate
        ,GETDATE()  As CurrentDate
        ,ABS(DATEDIFF(Year,GETDATE(),BirthDate)) As Employee_Age
FROM  Sales.Employees

--#Case 1.2
--#TASK:  --#Finding The Average Shipping duration in days for each month
SELECT 
           OrderID
          ,OrderDate
          ,ShipDate
          ,CONCAT(DATEDIFF(DAY,OrderDate,ShipDate),' ', 'Days') As Shipping_Duration
          ,CONCAT(AVG(DATEDIFF(DAY,OrderDate,ShipDate)) OVER(ORDER BY ShipDate),' ','Days') As Avg_Shipping_Duration
FROM Sales.Orders

--#Case 1.3  --#TIMEGAP ANALYSIS
--#TASK:  --#Finding The No Of days Btw Each Order & D Previous Order
SELECT 
          OrderID
        ,Quantity
        ,OrderDate As Current_Order_Date
       ,LAG(OrderDate) OVER(ORDER BY ShipDate) As Previous_OrderDate
       ,CONCAT(DATEDIFF(Day,LAG(OrderDate) OVER(ORDER BY ShipDate),OrderDate),' ','Days') As Days_BTW_Orders
FROM Sales.Orders


 --#DATE AND TIME FN( )     --#BRANCHED 🔀 🔆
                        --#VALIDATION FN( )   --#BRANCHED 🔀 🔆
--#ISDATE FN( )   --#Returns if Value is Date Format E.g(0= False , 1 = TRUE)
--#Case 1
SELECT '2025-03-18' As Str_Date
,ISDATE('2025-03-18') As Date_Validation  
--#Case 2
SELECT 'Sql_Query' As Str_Date
,ISDATE('Sql Query') As Date_Validation 
--#SINGLE ROW FUNCTION( )    --#BRANCH 🔅
            --#NULL FN( )     --#BRANCHED 🔀 🔆
--#IS NULL( )      &   --#COALESCE ( )   & NULL IF( )

--#Case 1
--#COALESCE  --#Task: Finding the avg score of the customers
SELECT 
         FirstName
        ,Score  [Score1]
        ,COALESCE(Score,0)  [Score2]
        ,AVG(Score) OVER() [Avg_Score]
        ,AVG(COALESCE(Score,0)) OVER() [Avg_Score2]
FROM Sales.Customers

--#Case 2 
SELECT 
          CustomerID
        ,CONCAT(FirstName,' ',LastName) [FullName]
        ,Country
        ,COALESCE(Score,0) [Normal_Score]
        ,COALESCE(Score,0) + 10 [Score_With_Bonus]
FROM Sales.Customers

--#ISNULL ()
--# Task : List all Cust Who Dont Have Scores   --#Case 1
SELECT *
FROM Sales.Customers
WHERE Score IS NULL

--#Case 2
SELECT *
FROM Sales.Orders
WHERE BillAddress  IS NULL


--#NULL IF ( )
--CASE 1
SELECT 
         OrderID
         ,OrderDate
         ,CONCAT('$',' ', Sales/NULLIF(Quantity,0)) [SalesPrice]
FROM Sales.Orders


--#IS NOT NULL ( )   --Opposite of NULL
--#Case 1
SELECT *
FROM Sales.Orders
WHERE BillAddress  IS NOT NULL



--#CASE STATEMENTS FN( )    --#CASE 1.0   --#TASK 1
       --#Building A Conditional LOGIC
SELECT 
           Category
          ,CONCAT('$', SUM(Sales)) [Tot_Sales]
FROM (
        SELECT 
                OrderID
               ,OrderDate
               ,Sales
           ,CASE
                WHEN Sales > 50 THEN 'High Sales'
                WHEN Sales > 24 THEN 'Medium Sales'
              ELSE  'Low Sales'  
              END  [Category]
        FROM Sales.Orders 
            ) Category
GROUP BY Category
ORDER BY  Tot_Sales ASC


--#CASE 1.1   --#TASK 2 :
SELECT *
FROM (
        SELECT 
               [EmployeeID]
              ,CONCAT([FirstName],' ',[LastName]) [FullName]
              ,[Department]
              ,[BirthDate]
              ,[Salary]
        ,CASE 
                WHEN  Gender = 'M' THEN 'Male'
        ELSE  'Female'
             END [Gender]
        FROM Sales.Employees
             ) [Employees]


--#CASE 1.2  --#TASK 3:
SELECT *
FROM (
        SELECT 
               [CustomerID]
              ,CONCAT([FirstName],' ',[LastName]) [FullName]
         ,CASE 
               WHEN [Country] = 'Germany'  THEN 'GER'
          ELSE 'US' 
          END  [Country Code]
              ,[Score]
        FROM Sales.Customers
              ) [Customers]

--#CASE 1.3  --#TASK 4;
SELECT *
 ,COALESCE([Normal Score],0)/2 [AVG_Score]
FROM (
        SELECT 
               [CustomerID]
              ,CONCAT([FirstName],' ',[LastName]) [FullName]
         ,CASE 
               WHEN [Country] = 'Germany'  THEN 'GER'
          ELSE 'US' 
          END  [Country Code]
              ,COALESCE([Score],0) [Normal Score]
        FROM Sales.Customers
              ) [Customers]


--#CASE 1.4  --#TASK 5:Counting The Times Each Customers Made an Order > Than 30
SELECT 
           CustomerID
        ,COUNT(Tot_Sales) [OrdersCount>30]
FROM (
        SELECT 
                OrderID
                ,CustomerID
               ,OrderDate
               ,SUM(Sales) OVER(ORDER BY OrderID)[Tot_Sales]
           ,CASE
                WHEN Sales > 50 THEN 'High Sales'
                WHEN Sales > 24 THEN 'Medium Sales'
              ELSE  'Low Sales'  
              END  [Category]
        FROM Sales.Orders 
            ) Category
WHERE Tot_Sales > 30
GROUP BY CustomerID
ORDER BY  CustomerID ASC;




