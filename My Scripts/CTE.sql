use SalesDB;

With CTE_Total_Sales AS 
( Select 
	CustomerID,
	Sum(Sales) As Total_Sales
From Sales.Orders 
Group By CustomerID ) 

, CTE_Last_Order AS

(Select 
	CustomerID, 
	Max(OrderDate) as Last_Order 
From Sales.Orders
Group By CustomerID)

,CTE_Customer_Ranking As

(Select 
	CustomerID,
	Total_Sales,
	Rank() Over(Order By Total_Sales Desc) as Ranking 
From CTE_Total_Sales)

, CTE_Customer_Segment as 

(
Select CustomerID,
Case When Total_Sales > 100 Then 'High'
	 When Total_Sales > 50 Then 'Medium'
	 Else 'Low'
End Segment
From CTE_Total_Sales
) 


Select 
	C.CustomerID,
	C.FirstName, 
	C.LastName,
	CTES.Total_Sales,
	CTEL.Last_Order,
	CTER.Ranking,
	CTECS.Segment
From Sales.Customers As C
Left Join CTE_Total_Sales As CTES 
On CTES.CustomerID= C.CustomerID
Left Join CTE_Last_Order As CTEL
On CTEL.CustomerID=C.CustomerID
Left Join CTE_Customer_Ranking CTER
On CTER.CustomerID=C.CustomerID
Left Join CTE_Customer_Segment CTECS
On CTECS.CustomerID=C.CustomerID
