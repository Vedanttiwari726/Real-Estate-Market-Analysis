CREATE DATABASE real_estate_db;
use real_estate_db;
select * from properties;

/* SECTION 1 : BUSINESS OVERVIEW 

 total properties */

select count(*) as total_properties 
from properties;

/* average price of property */

select
Round(avg(price),2)as avg_property_price
from properties;

/* highest property price*/

SELECT MAX(Price) AS Highest_property_Price
FROM properties;

/* lowest property price */

select min(price)As lowest_property_price
from properties;

/* Total of unique developers */

select count( distinct developer) as total_developer
from properties;

/*SECTION 2 : LOCATION ANALYSIS

Which are the top 10 areas with the highest number of property listings */

select `Area Name`,
count(*) as highest_property_listing
from properties
group by `Area Name`
order by highest_property_listing desc 
limit 10 ;	

/* Which top 10 areas have the highest average property price? */

select `Area Name`,
count(*) as total_listing,
Round(avg(price),2)as average_property_price
from properties
group by `Area Name`
order by average_property_price desc
limit 10;

/*Which areas have more than 100 property listings?*/

select `Area Name`,
count(*) as total_listing
from properties
group by `Area Name`
having count(*) > 100
order by total_listing desc;

/*Areas with an average property price above ₹2 Crore.*/
select `Area Name`,
count(*) as total_listing,
Round(avg(price),2) as avg_price
from properties
group by `Area Name`
having avg(price)>20000000
order by total_listing desc;

/*SECTION 2 : LOCATION ANALYSIS

Which BHK configuration has the highest number of property listings?*/

SELECT Property,
       COUNT(*) AS total_listings
FROM properties
WHERE Property <> ''
GROUP BY Property
ORDER BY total_listings DESC;

/* What is the average property price for each BHK category? */

select property,
  count(*) as total_listing,
Round(avg(price),2) as avg_BHK_price
from properties
where property <> ''
group by property
order by avg_BHK_price ;

/* Find the distribution of properties by property type. */

SELECT `Type of Property`,
       COUNT(*) AS total_listings
FROM properties
GROUP BY `Type of Property`
ORDER BY total_listings DESC;

/* Find the average property price for each property type.*/
select `Type of Property`,
count(*) as total_listings,
Round(avg(price),2) as avg_property_price
from properties
group by `Type of Property`
order by total_listings;

/*Find the distribution of properties by furnished type.*/

select `Furnished Type`,
  count(*)as total_listings
from properties
group by `Furnished Type`
order by total_listings desc;

/*  Find the average property price for each furnished type. */

select `Furnished Type`,
count(*) as total_listings,
Round(avg(price),2) as avg_furnished_property_price
from properties
group by `Furnished Type`
order by total_listings desc;

/* SECTION 4 : DEVELOPER ANALYSIS

Find the top 10 developers with the highest number of property listings (excluding 'Unknown') */

select Developer,
count(*) as highest_listed_property
from properties
where Developer <> 'Unknown'
group by Developer
order by highest_listed_property desc
limit 10;

/* Find the average property price for each developer having at least 10 property listings */

select Developer,
count(*) as total_listings,
Round(avg(price),2) as avg_property_price
from properties
where Developer <> 'Unknown'
group by Developer
having total_listings >= 10
order by total_listings desc;

/* Find developers having more than 50 property listings. */

select Developer,
count(*) as total_listings
from properties
where Developer <> 'Unknown'
group by Developer
having total_listings >50
order by total_listings desc;

/*  SECTION 5 : PRICE ANALYSIS */

/*Find the top 10 most expensive properties*/
SELECT Price,
       `Area Name`,
       Property,
       Developer,
       `Type of Property`
FROM properties
ORDER BY Price DESC
LIMIT 10;

/*Find the top 10 least expensive properties. */
SELECT Price,
       `Area Name`,
       Property,
       Developer,
       `Type of Property`
FROM properties
ORDER BY Price asc
LIMIT 10;

/*Find all properties priced above the overall average property price.*/

SELECT Price,
       `Area Name`,
       Property,
       Developer,
       `Type of Property`
FROM properties
WHERE Price > (
    SELECT AVG(Price)
    FROM properties
);

/* SECTION 6 : ADVANCED SQL ANALYSIS
----Rank all areas based on their average property price
 */
 
SELECT
    `Area Name`,
    AVG(Price) AS Avg_Price,
    DENSE_RANK() OVER (ORDER BY AVG(Price) DESC) AS Area_Rank
FROM properties
GROUP BY `Area Name`;

/*Find all properties priced higher than their area's average property price.*/

SELECT
    Price,
    `Area Name`,
    Property,
    Developer,
    `Type of Property`
FROM properties p
WHERE Price > (
    SELECT AVG(Price)
    FROM properties
    WHERE `Area Name` = p.`Area Name`
);

/* Create a reusable SQL View containing all premium properties whose price is above ₹5 Crore. */

CREATE VIEW Premium_Properties AS
SELECT
    Price,
    `Area Name`,
    Property,
    Developer,
    `Type of Property`
FROM properties
WHERE Price > 50000000;

