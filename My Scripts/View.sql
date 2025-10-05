

-- Task: Provide View that combines details from orders, products , customers and employees

Create View Sales.V_Order_Details As
(
	Select 
	O.OrderID, 
	P.ProductID,
	P.Category,
	Coalesce (C.FirstName,' ')+' '+Coalesce(c.LastName,' ') As CustomerName,
	C.Country CustomerCountry,
	coalesce (E.FirstName,' ' )+ ' '+ Coalesce (E.LastName,' ') As EmployeeName,
	E.Department,
	O.CustomerID,  
	O.OrderDate,
	O.Sales,
	O.Quantity 
	From Sales.Orders O
	Left Join Sales.Products P
	On P.ProductID=O.ProductID
	Left Join Sales.Customers C 
	On C.CustomerID = O.CustomerID
	Left Join Sales.Employees E
	On E.EmployeeID= O.SalesPersonID
)







