-- Super Bowl TV Spots 2001-2023

-- Create table the same way it is in the csv file (column names and types)
CREATE TABLE spots(
	Year INT,
	Brand varchar(30),
	Funny	BIT,
	Shows_Product_Quickly BIT,
	Patriotic BIT,
	Celebrity BIT,
	Danger BIT,
	Animals BIT,
	Uses_Sex BIT,
	[Length] INT,
	Estimated_Cost DECIMAL(5,2),
	YT_Views INT,
	YT_Likes INT, 
	TV_Viewers DECIMAL(5,2)
)

-- Check everything is in the table after uploadting it from SSIS
SELECT * FROM spots


-- Total number of commercials per brand
SELECT Brand, count(Brand) as tv_spots
FROM spots
GROUP by Brand
ORDER BY tv_spots desc

-- Total # of tv_spots of every brand per year
SELECT Year, Brand, count(Brand) as tv_spots
FROM spots
GROUP BY Year, Brand
ORDER BY tv_spots desc

-- Average ad length per brand
SELECT Brand, avg(Length) as avg_time
FROM spots
GROUP BY brand
ORDER BY avg_time desc

-- Average YT_viewers per brand
SELECT Brand, avg(YT_views) as avg_views
FROM spots
GROUP BY brand
ORDER BY avg_views desc

-- Funny commercials per brand
SELECT Brand, count(Funny) as Funny_spots
FROM spots
WHERE Funny = 1
GROUP BY Brand

-- Cost-effectiveness analysis
SELECT Brand, avg(Estimated_cost) as avg_cost, avg(YT_views) as avg_views
FROM spots
GROUP BY Brand
ORDER BY avg_views desc, avg_cost asc

-- TOTAL expenses per Brand
SELECT Brand, SUM(Estimated_cost) as total_expenses
FROM spots
GROUP BY Brand
ORDER BY total_expenses desc
