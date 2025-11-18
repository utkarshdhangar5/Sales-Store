
select * from sales_store1

--Q1.What are the top 5 best-selling products by quantity?
select top 5 product_name, sum(quantity*price) as total_quantity
from sales_store1
group by product_name
order by total_quantity desc;

--Q2 Which product is most frequently canceled?
select product_name, count(*) as total_cancelled
from sales_store1
where status = 'cancelled'
group by product_name
order by total_cancelled desc;

--Q3 What time of the day has the highest number of purchases?
select 
       case
            when DATEPART(hour, time_of_purchase) between 0 and 5 then 'night'
            when DATEPART(hour, time_of_purchase) between 6 and 11 then 'morning'
            when DATEPART(hour, time_of_purchase) between 12 and 17 then 'afternoon'
            when DATEPART(hour, time_of_purchase) between 18 and 23 then 'evening'
            end as time_of_day,
            Count(*) As total_order
            from sales_store1
            group by 
            case
            when DATEPART(hour, time_of_purchase) between 0 and 5 then 'night'
            when DATEPART(hour, time_of_purchase) between 6 and 11 then 'morning'
            when DATEPART(hour, time_of_purchase) between 12 and 17 then 'afternoon'
            when DATEPART(hour, time_of_purchase) between 18 and 23 then 'evening'
            end
            order by total_order desc;


--Q4.	Who are the top 5 highest spending customers?
select top 5 customer_name, sum(quantity*price) as ammount_spent
from sales_store1
group by customer_name
order by ammount_spent desc;

--Q5 5.	Which product categories generate the highest revenue?
select product_category,
format(sum(quantity*price),'C0','en-In') as total_revenue
from sales_store1
group by product_category
order by total_revenue desc;

select product_category, sum(quantity*price) as total_revenue
from sales_store1
group by product_category
order by total_revenue desc;

 -- 6 what is the return / cancellation rate per product category ?
 select product_category, 
 format(count(case when status in ('returned','cancelled') then 1 end) * 100.0/count(*),'N2') +'%' 
 as cancelled_percent
 from sales_store1
 group by product_category
 order by cancelled_percent desc;

 --7 what is the most perferredpayment mode?
 select payment_mode, count(payment_mode) as total_count
 from sales_store1
 group by payment_mode
 order by total_count desc;

 --8 How des the age group affect purchasing behaviour?
select customer_age, count(*) as purchase_count,
sum(quantity*price) as total_spent
from sales_store1
group by customer_age;

select 
case
when customer_age between 18 and 25 then '18-25'
when customer_age between 26 and 35 then '26-35'
when customer_age between 36 and 45 then '36-45'
when customer_age between 46 and 60 then '46-60'
else '60+'
end as age_group,
count(*) as total_purchase,
sum(quantity*price) as total_spent
from sales_store1
group by case 
when customer_age between 18 and 25 then '18-25'
when customer_age between 26 and 35 then '26-35'
when customer_age between 36 and 45 then '36-45'
when customer_age between 46 and 60 then '46-60'
else '60+'
end 
order by total_spent desc;

--9 What is monthly trend?

select year(purchase_date) as year,
month(purchase_date) as month,
sum(quantity*price) as month_sales
from sales_store1
group by year(purchase_date),month(purchase_date)
order by year,month;

--10 Are certain genders buyng more specific product categories?
select gender,product_category,count(*) as purchase_count,
sum(quantity*price) as total_spent
from sales_store1
group by gender, product_category
order by gender, total_spent desc;