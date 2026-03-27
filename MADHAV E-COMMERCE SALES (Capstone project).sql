create database Madhav;
use madhav;

-- Q1. find Total number of orders.
select count(Order_ID) as total_numbers_order
from orders;

-- Q:2 Find Total Sales.
select sum(Amount) as total_sales
from details;


-- Q:3 find Total Profit
select avg(Amount) as total_profit
from details;

-- Q4. find Average Order Value..
select sum(Amount)/count(distinct Order_ID)  as avg_order_value
from details;

-- Q5. Find Sales by Category
select category, sum(Amount) as sales
from details
group by Category;

-- Q6. find Profit by Category.
select category , sum(Profit) as profit
from details
group  by category;

-- Q7. find top Sales by State.
select state, sum(Amount) as sales
from orders o natural join details d
group by State
order by sales desc;

-- Q8. find Top 5 Customers by Sales
select Customer_Name , sum(Amount) as top_sales
from orders o natural join details d
group by Customer_Name
order by top_sales desc
limit 5;

-- Q9. find Monthly Sales
select month(Order_Date) as month,
sum(Amount) as monthly_sales
from orders o natural join details d
group by month(Order_Date)
order by month;

-- Q12. find the Customers whose sales above average
SELECT Customer_Name, Total_Sales
FROM (SELECT o.Customer_Name, SUM(d.Amount) AS Total_Sales
    FROM Orders o
    JOIN Details d
    ON o.Order_ID = d.Order_ID
    GROUP BY o.Customer_Name) t
WHERE Total_Sales > (SELECT AVG(Total_Sales)
FROM (SELECT SUM(Amount) AS Total_Sales
        FROM Details
        GROUP BY Order_ID
    ) x
);

-- Q13. Find Rank customers by sales
select Customer_Name, sum(Amount) as sales,
Rank() over(order by sum(Amount) desc) as rnk_customers
from orders o natural join details d
group by Customer_Name;