use revenue;

rename table revenue_profit_cost_efficiency_dataset to sales_data;

ALTER TABLE sales_data
MODIFY Revenue DECIMAL(12,2),
MODIFY COGS DECIMAL(12,2),
MODIFY Operating_Cost DECIMAL(12,2),
MODIFY Marketing_Cost DECIMAL(12,2),
MODIFY Total_Cost DECIMAL(12,2),
MODIFY Profit DECIMAL(12,2),
MODIFY Profit_Margin_Percentage DECIMAL(6,2);

select count(*) from sales_data;

SELECT * FROM sales_data LIMIT 5;

DESCRIBE sales_data;

-- Check total business numbers
select sum(Revenue)Total_Revenue,
sum(Total_Cost)Total_Cost,
sum(Profit)Total_Profit
from sales_data;

-- Region-wise performance
select Region,
sum(Revenue)Total_Revenue,
sum(Total_Cost)Total_Cost,
sum(Profit)Total_Cost
from sales_data
group by Region;

-- Product profitability
select Product,
sum(Revenue)Total_Revenue,
sum(Profit)Total_Profit
from sales_data
group by Product
order by Total_Profit desc;

-- Cost efficiency
select Product,
round(sum(Profit)/sum(Revenue)*100,2)Profit_Margin_Percentage
from sales_data
group by Product
order by Profit_Margin_Percentage desc;

-- Monthly trend
select year(date)Year,
month(date)Month,
sum(Revenue)Revenue,
sum(Profit)Profit
from sales_data
group by year,month
order by year,month;

-- Loss-making records
select * from sales_data
where Profit < 0;

-- Marketing Cost vs Profit Impact
select Product,
sum(Marketing_Cost)Marketing_Cost,
sum(Profit)Profit
from sales_data
group by Product
order by Marketing_Cost desc;

-- Category-wise Profit Margin
select Category,
round(sum(Revenue)/sum(Profit)*100,2)Profit_Margin_Percentage
from sales_data
group by category
order by Profit_Margin_Percentage desc;

-- Loss-Making Products
select Product,
sum(Revenue)Revenue,
sum(Profit)Profit
from sales_data
group by Product
having Profit < 0;

select Product,Category
from sales_data;

-- Cost Contribution Breakdown
select Product,
sum(COGS)COGS,
sum(Marketing_Cost)Marketing_Cost,
sum(Operating_Cost)Operating_Cost
from sales_data
group by Product;

-- KPI summary
select count(distinct Product)Total_Products,
sum(Revenue)Total_Revenue,
sum(Total_Cost)Total_Cost,
sum(Profit)Total_Profit,
round(sum(Profit)/sum(Revenue)*100,2)Overall_Profit_Margin
from sales_data;