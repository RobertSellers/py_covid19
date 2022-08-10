library(sqldf)

query1 <- "SELECT  *, COUNT(*)
FROM data
GROUP BY segment, date, country, product, `Discount Band`
HAVING COUNT(*) >1;"

sqldf(query1)

query2 <- "SELECT  Product, SUM(sales) as total_sales
FROM data
WHERE Country = 'Canada'
GROUP BY Product
ORDER BY total_sales DESC
LIMIT 1;"

sqldf(query2)

query3 <- "select a.product, (a_cost - b_cost) as sales_increase
from (select product, year, sum(a.sales) as a_cost
from data a
where a.year = 2014
group by product) a left join
(select product, year, sum(b.sales) as b_cost
from data b
where b.year = 2013
group by product)
b on a.product = b.product;"

sqldf(query3)

query4 <- "SELECT  Segment, SUM(profit) as total_profit
FROM data
GROUP BY Segment
ORDER BY total_profit DESC
LIMIT 1;"

sqldf(query4)

query5 <-"Select d2.country, d2.product, sum(sales) FROM 
(SELECT distinct d.country, product from data
CROSS JOIN (Select distinct country from data) d) d2
FULL OUTER JOIN data
ON d2.country = data.country AND d2.product = data.product
group by d2.country, d2.product;"

sqldf(query5)