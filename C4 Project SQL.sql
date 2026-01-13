-- Select * from dhl_delivery_agents
Select * from dhl_orders
-- Select * from dhl_routes
Select * from dhl_shipments
-- Select * from dhl_warehouses

-- Task 1.3: Standardize date formats
 ALTER TABLE dhl_orders
 MODIFY Order_Date DATETIME

 ALTER TABLE dhl_shipments
 MODIFY Pickup_Date DATETIME
 MODIFY Delivery_Date DATETIME; 

-- Task 1.4: Flagging invalid dates
 SELECT * FROM dhl_shipments WHERE Delivery_Date < Pickup_Date;
-- Result: No invalid date found

-- Task 1.5: Referential Integrity Checks 
 SELECT * FROM dhl_shipments s
 LEFT JOIN dhl_orders o ON s.Order_ID = o.Order_ID
 WHERE o.Order_ID IS NULL; 
-- Result: Nothing found

-- Task 2.1: Calculate actual delay
 SELECT Shipment_ID,
       TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date) AS Actual_Delay_Hours
 FROM dhl_shipments; 
-- Result: Actual delay hours for each delivery displayed

-- Task 2.2: Top 10 delayed routes
 SELECT Route_ID, AVG(Delay_Hours) AS Avg_Delay FROM dhl_shipments
 GROUP BY Route_ID
 ORDER BY Avg_Delay DESC
 LIMIT 10; 
-- Result: Top 10 delivery routes as per decreasing order of average delay displayed

-- Task 2.3: Ranking shipments by delay per warehouse
 SELECT Shipment_ID, Warehouse_ID, Delay_Hours,
       RANK() OVER (PARTITION BY Warehouse_ID ORDER BY Delay_Hours DESC) AS Delay_Rank
 FROM dhl_shipments; 
-- Result: Shipments by delay per warehouse displayed

-- Task 2.4: Express vs Standard delay
 SELECT o.Delivery_Type, AVG(s.Delay_Hours) AS Avg_Delay
 FROM dhl_shipments s
 JOIN dhl_orders o ON s.Order_ID = o.Order_ID
 GROUP BY o.Delivery_Type; 
-- Result: Average standard delivery delay is of upto 21 hours, and average express delviery delay is of 22 hours. 

-- Task 3.1 & 3.2: Average transit time (in hours) & delay across all shipments
 SELECT r.Route_ID,
       AVG(s.Delay_Hours) AS Avg_Delay,	AVG(TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date) / 3600) AS Avg_Transit
 FROM dhl_shipments s
 JOIN dhl_routes r ON s.Route_ID = r.Route_ID
 GROUP BY r.Route_ID; 
-- Result: Average delay and average transit time in hours displayed 

-- Task 3.3 & 3.4: Distance-to-time efficiency ratio and top 3 routes with worst efficiency ratio
 SELECT Route_ID, Distance_KM / Avg_Transit_Time_Hours AS Efficiency_Ratio
 FROM dhl_routes ORDER BY Efficiency_Ratio ASC
 LIMIT 3; 
-- Result: Efficiency Ration displayed for top worst performing routes

-- Task 3.5: Routes with >20% delayed shipments
 SELECT Route_ID,
       SUM(CASE WHEN Delay_Hours > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Delay_Percentage
 FROM dhl_shipments
 GROUP BY Route_ID
 HAVING SUM(CASE WHEN Delay_Hours > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) > 20; 
-- Result: Delay percentage with more than 20% shipments displayed

-- Task 4.1: Top 3 warehouses by delay
  SELECT Warehouse_ID, AVG(Delay_Hours) AS Avg_Delay FROM dhl_shipments
 GROUP BY Warehouse_ID
 ORDER BY Avg_Delay DESC
 LIMIT 3; 
-- Result: top 3 warehouses by delay displayed

-- Task 4.2: Total vs delayed shipments
 SELECT Warehouse_ID,
       COUNT(*) AS Total_Shipments,
       SUM(CASE WHEN Delay_Hours > 0 THEN 1 ELSE 0 END) AS Delayed_Shipments
 FROM dhl_shipments
 GROUP BY Warehouse_ID; 
-- Result: Total vs delayed shipments displayed

-- Task 4.3: Warehouses above global average delay
 WITH global_avg AS (
    SELECT AVG(Delay_Hours) AS g_avg FROM dhl_shipments
 )
 SELECT Warehouse_ID, AVG(Delay_Hours)
 FROM dhl_shipments, global_avg
 GROUP BY Warehouse_ID, g_avg
 HAVING AVG(Delay_Hours) > g_avg; 
-- Result: Desired result displayed

-- Task 4.4: On-time delivery ranking
 SELECT Warehouse_ID,
       SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS OnTime_Percentage
 FROM dhl_shipments
 GROUP BY Warehouse_ID
 ORDER BY OnTime_Percentage DESC;

-- Task 5.1: Rank agents per route
 SELECT Agent_ID,
       Route_ID,
       SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS OnTime_Percentage,
       RANK() OVER (PARTITION BY Route_ID 
                    ORDER BY SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) DESC) AS Ranking
FROM dhl_shipments
GROUP BY Agent_ID, Route_ID; 
-- Result: Agents on route ranked and displayed

-- Task 5.2: agents whose on-time % is below 85%
 SELECT Agent_ID
 FROM dhl_shipments
 GROUP BY Agent_ID
 HAVING SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) < 85 
-- Result: Agents whose on-time percentage is below 85% is displayed

-- Task 5.3: Top 5 vs Bottom 5 agents
SELECT da.* FROM dhl_delivery_agents da
JOIN (
    SELECT Agent_ID
    FROM dhl_shipments
    GROUP BY Agent_ID
    ORDER BY SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) DESC
    LIMIT 5
) top_agents
ON da.Agent_ID = top_agents.Agent_ID

UNION ALL

SELECT da.* FROM dhl_delivery_agents da
JOIN (
    SELECT Agent_ID
    FROM dhl_shipments
    GROUP BY Agent_ID
    ORDER BY SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) ASC
    LIMIT 5
) bottom_agents
ON da.Agent_ID = bottom_agents.Agent_ID; 
-- Result: Top 5 top and bottom displayed

-- Task 6.1: Latest shipment status
 SELECT Shipment_ID, Delivery_Status, MAX(Delivery_Date) AS Latest_Date
FROM dhl_shipments
GROUP BY Shipment_ID, Delivery_Status; 
-- Result: Delivery status displayed for all shipments

-- Task 6.2: Routes mostly In-Transit or Returned
SELECT Route_ID
FROM dhl_shipments
GROUP BY Route_ID
HAVING SUM(Delivery_Status IN ('In Transit', 'Returned')) > COUNT(*) / 2;  
-- Result: Nothing returned

-- Task 6.3: Delay Reasons
SELECT
    Delay_Reason,
    COUNT(*) AS Delay_Count
FROM dhl_shipments
WHERE Delay_Hours > 0
  AND Delay_Reason IS NOT NULL
GROUP BY Delay_Reason
ORDER BY Delay_Count DESC;
-- Result: Traffic is the most common reason of delay, followed by weather and technical issue

-- Task 6.4: High-delay shipments (>120 hrs)
SELECT *
FROM dhl_shipments
WHERE Delay_Hours > 120;
-- Result: Shipments with more than 120 hours of delay displayed

-- Task 7.1: Avg delay per source country
SELECT r.Source_Country, AVG(s.Delay_Hours)
FROM dhl_shipments s
JOIN dhl_routes r ON s.Route_ID = r.Route_ID
GROUP BY r.Source_Country;
-- Result: Delay displayed

-- Task 7.2: On-Time Delivery Percentage
SELECT
    SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) 
        AS On_Time_Delivery_Percentage
FROM dhl_shipments;

-- Task 7.3: Average delay (in hours) for each route
SELECT Route_ID, AVG(Delay_Hours) AS Avg_Delay_Hours
FROM dhl_shipments
GROUP BY Route_ID;
-- Result: Average delay hours for each route calculated

-- Task 7.4: Warehouse utilization
SELECT w.Warehouse_ID,
       COUNT(s.Shipment_ID) * 100.0 / w.Capacity_per_day AS Utilization_Percentage
FROM dhl_warehouses w
LEFT JOIN dhl_shipments s ON w.Warehouse_ID = s.Warehouse_ID
GROUP BY w.Warehouse_ID, w.Capacity_per_day;
-- Result: Warehpuse utilisation percentage for each warehouse calculated
