SELECT * FROM sample_sales.store_managers
where Store_Manager like "Shruti%";
/*
What is total revenue overall for sales 
in Maryland, plus the start date 
and end date that tell you what period the data covers?
*/
WITH TotalSales AS (
    SELECT
        ss.Store_ID,
        ss.Transaction_Date,
        SUM(ss.Sale_Amount) AS StoreSales,
        SUM(os.SalesTotal) AS OnlineSales,
        SUM(ss.Sale_Amount + os.SalesTotal) AS TotalSales
    FROM sample_sales.store_sales AS ss
    JOIN sample_sales.online_sales AS os
        ON ss.id = os.id
    WHERE ss.Store_ID > 730 AND ss.Store_ID < 740
    AND Transaction_Date BETWEEN '2022-01-01' AND '2022-01-31'
    GROUP BY ss.Store_ID, ss.Transaction_Date
)

SELECT
    SUM(ts.TotalSales) AS OverAllSales,
    ts.Transaction_Date,
    sl.State,
    sl.City
FROM TotalSales ts
JOIN sample_sales.store_list sl
    ON ts.Store_ID = sl.Store_ID
WHERE sl.State = 'Maryland'
GROUP BY ts.Transaction_Date, sl.State, sl.City
ORDER BY Transaction_Date ASC, City ASC;

/*
What is the month by month 
revenue breakdown for the sales territory?
*/
select sum(ss.Sale_Amount + os.SalesTotal) as TotalSales, sl.State
from sample_sales.store_sales as ss
join sample_sales.online_sales as os
	on ss.id = os.id
join sample_sales.store_list as sl
	on ss.Store_ID = sl.Store_ID
where ss.Store_ID between 731 and 739
	and Transaction_Date between '2023-01-01' and '2023-01-31'
	and sl.State = 'Maryland'
group by sl.State;

/*
Provide a comparison of total revenue for 
the specific sales territory and the region it belongs to.
*/
select sum(ss.Sale_Amount + os.SalesTotal) as TotalSales, sl.State
from sample_sales.store_sales as ss
join sample_sales.online_sales as os
	on ss.id = os.id
join sample_sales.store_list as sl
	on ss.Store_ID = sl.Store_ID
where Transaction_Date between '2023-01-01' and '2023-01-31'
group by sl.State
Order by sl.State asc;

/*
What is the number of transactions per month and average 
transaction size by product category for the sales territory?
*/


/*
Can you provide a ranking of in-store sales performance by each store in the sales territory, or 
a ranking of online sales performance by state within an online sales territory?
*/