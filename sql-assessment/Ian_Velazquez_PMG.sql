-- Ian Velazquez 

--Question1

SELECT SUM(IMPRESSIONS) AS impressions_per_day, datetime FROM marketing_performance
GROUP BY datetime
ORDER BY datetime ASC;

--Question2

SELECT DISTINCT marketing_performance.geo, SUM(website_revenue.revenue) 
FROM marketing_performance
LEFT JOIN website_revenue
ON marketing_performance.campaign_id = website_revenue.campaign_id
GROUP BY marketing_performance.geo
ORDER BY SUM DESC
LIMIT 3;

--The 3rd best state was United States-OH and it generated 214898

--Question3

SELECT 

name,
SUM(CAST(marketing_performance.cost AS bigint)) AS total_cost, 
SUM(CAST(marketing_performance.impressions AS bigint)) AS total_impressions, 
SUM(CAST(marketing_performance.clicks AS bigint)) AS total_clicks,
SUM(CAST(website_revenue.revenue AS bigint)) AS total_revenue
		
FROM campaign_info

LEFT OUTER JOIN marketing_performance
ON CAST(marketing_performance.campaign_id AS bigint) = campaign_info.id

LEFT OUTER JOIN website_revenue
ON CAST(website_revenue.campaign_id AS bigint) = campaign_info.id

GROUP BY campaign_info.name

ORDER BY name;

--Question4

SELECT 
DISTINCT(campaign_info.name), 
SUM(CAST(marketing_performance.conversions AS bigint)) AS total_conversions, 
website_revenue.state 

FROM campaign_info

LEFT OUTER JOIN marketing_performance
ON CAST(marketing_performance.campaign_id AS bigint)=campaign_info.id

LEFT OUTER JOIN website_revenue
ON CAST(website_revenue.campaign_id AS bigint) = campaign_info.id

WHERE name = 'Campaign5'

GROUP BY campaign_info.name, website_revenue.state

ORDER BY total_conversions DESC;

--GA/Georgia generated the most conversions for this campaign

--Question5

--I used the following query to obtain the total revenue and cost per state (I changed the WHERE statement to filter through campaigns):

SELECT 
DISTINCT(campaign_info.name), 
SUM(CAST(marketing_performance.conversions AS bigint)) AS total_conversions, 
website_revenue.state, 
SUM(CAST(website_revenue.revenue  AS bigint)) AS total_rev, 
SUM(CAST(marketing_performance.cost AS bigint)) AS total_cost

FROM campaign_info

LEFT OUTER JOIN marketing_performance
ON CAST(marketing_performance.campaign_id AS bigint)=campaign_info.id

LEFT OUTER JOIN website_revenue
ON CAST(website_revenue.campaign_id AS bigint) = campaign_info.id

WHERE name = 'Campaign2'

GROUP BY  website_revenue.state, campaign_info.name

ORDER BY total_conversions DESC;

--From here, I used the Cost/Revenue formula to see which campaign yielded the lowest percentage:

--Campaign 1: 
--Total Cost = 1390 x 3 = 4170
--Total Rev = 50960 + 44568 + 56264
--Total Conversions = 3018 x 3 = 9053
--States = 3

--Cost : Rev = (4170 / 50960) x 100  = 8.18%


--Campaign 2: 
--Total Cost = (1360 x 2) + (680 x 2) = 4080
--Total Rev = 52748 + 53640 + 25624 + 23296 = 155308
--Total Conversions = (3032 x 2) + (1516 x 2) = 9096
--States = 4 

--(4080 / 155308) x 100 = 2.63%

--Campaign 3: 
--Total Cost = (3954 x 2) + 5931 + 1977 = 15816
--Total Rev = 200860 + 132715 + 140206 + 77891 = 551672
--Total Conversions = (8902 x 2) + 13353 + 4451 = 35608
--States = 4 

--(15816 / 551672) x 100 = 2.87%

--Campaign 4: 
--Total Cost = (1324 x 2) + (662 x 2) = 3972
--Total Rev = 52636 + 54748 + 29788 + 26224 = 163396
--Total Conversions = (3102 x 2) + (1551 x 2) = 9306
--States = 4 

--(3972 / 163396) x 100 = 2.43%

--Campaign 5: 
--Total Cost = (583 x 2) + 1749 + 1116 = 4031
--Total Rev = 60327 + 42720 + 15390 + 17967 = 136404
--Total Conversions = (1114 x 2) + 3342 + 2228 = 7798
--States = 4 

--(4031 / 136404) x 100 = 2.96%

--Based on this information, Campaign 4 was the most efficient campaign because it yielded more revenue by investing less cost. However, Campaign 3 did yield the most conversions so this can be taken into consideration as well.

-- Question 6

SELECT  EXTRACT (ISODOW FROM datetime) AS days_of_week, 
SUM(impressions) AS impressions, 
SUM(clicks) AS clicks
FROM marketing_performance
GROUP BY  EXTRACT (ISODOW FROM datetime)
ORDER BY SUM(impressions) DESC; 

--While Friday has the most impressions, Sunday has the most clicks. However, Friday has the most impressions and clicks combined. Based on this information, Friday would be the best day to run ads.   
