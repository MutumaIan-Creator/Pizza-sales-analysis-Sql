use [Portfolio Project]

--PART A: LET US COME UP WITH OUR KPI's

--Total Revenue
Select sum (total_price) as TotalRevenue
from pizza_sales

--Select*from pizza_sales
--Average_Order_value

select (sum(total_price)/count(distinct(order_id))) as Average_Order_Value
from pizza_sales

--Total Pizzas Sold

Select sum(quantity) as Total_Pizzas_Sold
from pizza_sales

--Total Orders

Select Count(distinct(order_id)) as TotalOrders
from pizza_sales

--Average Pizzas Per Orders

Select CAST(sum(quantity) as decimal(10,2))/
CAST(count(distinct order_id) as decimal (10,2))
as Average_Pizzas_Per_Order
From pizza_sales


--PART B: LET'S NOW WORK ON OUR DAILY TRENDS

--Daily order trends

select Datename (DW, order_date) as Order_day,count(distinct order_id) as Total_Orders_by_Day
from pizza_sales
group by Datename (DW, order_date)
ORDER BY Datename (DW, order_date)

--Hourly trends

Select DATEPART(Hour,order_time) as Order_hours, count(distinct order_id) as Total_Orders_by_Hour
from pizza_sales
group by DATEPART(Hour,order_time)
order by DATEPART(Hour,order_time)

--Percentage of Sales By category

SELECT pizza_category, SUM(total_price) as total_revenue,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_category

--Percentage of Sales by Pizza Size

SELECT pizza_size, SUM(total_price) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size


--Total Pizzas sold by Category

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--Top 5 best selling Pizzas

SELECT Top 5 pizza_name_id, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name_id
ORDER BY Total_Pizza_Sold DESC

--Bottom 5 selling Pizzas

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC



