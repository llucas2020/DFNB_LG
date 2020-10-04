/* Question: By Order Quantity, what were the five most popular products sold in 2014?

Include these data points in the output:
- Order Date Year
- Product ID
- Product Name
- Product Number
- Product Color
- Sales Order Count
- Order Quantity
- Sales Order Line total */

SELECT TOP 5 YEAR(soh.OrderDate) AS OrderDateYear
           , p.ProductID
           , p.Name AS ProductName
           , p.ProductNumber
           , p.Color AS ProductColor
           , COUNT(sod.SalesOrderID) AS SalesOrderIDCount
           , SUM(sod.OrderQty) AS OrderQtySum
           , SUM(sod.LineTotal) AS SalesOrderLineTotalSum
  FROM Production.Product AS p
       INNER JOIN
       Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
       INNER JOIN
       Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
 WHERE YEAR(soh.OrderDate) = 2014
 GROUP BY YEAR(soh.OrderDate)
        , p.ProductID
        , p.Name
        , p.ProductNumber
        , p.Color
 ORDER BY 7 DESC;

 /* Question 2: How long are the 7 longest Person names and to whom do they belong? Rank by Full Name length, Last Name Length, First Name Length

Include these data points in the output:
Business Entity ID
Full Name
Full Name Length
First Name
First Name Length
Middle Name
Last Name
Last Name Length */

SELECT TOP 7 p.BusinessEntityID
           , REPLACE(COALESCE(p.FirstName, '') + ' ' + COALESCE(p.MiddleName, '') + 
		   ' ' + COALESCE(p.LastName, ''), ' ', ' ') AS FullName
           , LEN(REPLACE(COALESCE(p.FirstName, '') + ' ' + COALESCE(p.MiddleName, ''
		   ) +  ' ' + COALESCE(p.LastName, ''), ' ', ' ')) AS FullNameLength
           , p.FirstName
           , LEN(p.FirstName) AS FirstNameLength
           , p.MiddleName
           , LEN(p.MiddleName) AS MiddleNameLength
           , p.LastName
           , LEN(p.LastName) AS LastNameLength
  FROM Person.Person AS p
 ORDER BY FullNameLength DESC;

 /* Question 3: Which Department pays its female workers on average the most per year?

Include these fields:
Department ID
Department Name
Gender
Total Yearly Pay
Business Entity ID Count
Average Yearly Pay */

WITH s1 
as (
SELECT d.DepartmentID
     , d.Name AS DepartmentName
     , e.Gender
     , e.SalariedFlag
     , eph.Rate
     , eph.PayFrequency
     , CASE
           WHEN e.SalariedFlag = 1
           THEN eph.Rate * 1000
           WHEN e.SalariedFlag = 0
           THEN eph.Rate * 2080
           ELSE 0
       END AS YearlyPay
     , COUNT(e.BusinessEntityID) AS BusinessEntityIDCount
   ,CASE
           WHEN e.SalariedFlag = 1
           THEN eph.Rate * 1000
           WHEN e.SalariedFlag = 0
           THEN eph.Rate * 2080
           ELSE 0
       END * COUNT(e.BusinessEntityID) AS TotalYearlyPay
  FROM HumanResources.Department AS d
       JOIN
       HumanResources.EmployeeDepartmentHistory AS edh ON d.DepartmentID = edh.DepartmentID
       JOIN
       HumanResources.EmployeePayHistory AS eph ON edh.BusinessEntityID = eph.BusinessEntityID
       JOIN
       HumanResources.Employee AS e ON edh.BusinessEntityID = e.BusinessEntityID
 WHERE e.Gender LIKE 'F'
 GROUP BY d.DepartmentID
        , d.Name
        , e.Gender
        , e.SalariedFlag
        , eph.Rate
        , eph.PayFrequency
      )
SELECT s1.DepartmentID
     , s1.DepartmentName
     , s1.Gender
     , SUM(p.BusinessEntityIDCount) AS BusinessEntityIDCount
     , SUM(p.TotalYearlyPay) AS TotalYearlyPay
     , SUM(p.TotalYearlyPay) / SUM(p.BusinessEntityIDCount) AS AvgYearlyPay
  FROM s1 AS s
 GROUP BY s.DepartmentID
        , s.DepartmentName
        , s.Gender
 ORDER BY AvgYearlyPay DESC;