Project Overview:

DHL, one of the world’s leading logistics and courier service providers, operates an extensive global air and ground transportation network, connecting more than 220 countries and territories through major hubs in Leipzig, Cincinnati, Hong Kong, Dubai, and Singapore.
The network includes international sortation centers, regional hubs, and last-mile delivery partners that handle millions of shipments daily across continents.
As global e-commerce volumes continue to surge — especially during peak seasons and holidays — flight delays, customs bottlenecks, and last-mile congestion significantly impact both on-time delivery performance and operational costs.
Currently, DHL’s logistics operations face challenges in:
● Identifying the root causes of transit and delivery delays (e.g., customs clearance, weather disruptions, route congestion).
● Optimizing international and regional routes for faster, more cost-effective deliveries.
● Improving shipment efficiency, warehouse throughput, and delivery agent performance
using data-driven insights.
The logistics data, stored in relational databases, can be analyzed using SQL to extract meaningful performance metrics and delay patterns.
These insights can help DHL improve hub utilization, route planning, and service-level reliability across its international network.

Project Objective I have delivered:

In this project, I have developed a SQL-driven logistics analytics system to analyze shipment performance, optimize routes, and enhance delivery efficiency across DHL’s global network.
The project aims to:
● Identify delay patterns and operational inefficiencies.
● Optimize hub and route combinations for improved transit times.
● Analyze agent- and warehouse-level performance.

The dataset has the following key tables:

1. Orders Table
The Orders dataset contains order-level delivery details including order date, route, warehouse, and payment type.
Order_ID, Customer_ID, Order_Date, Route_ID, Warehouse_ID, Order_Amount, Delivery_Type, Payment_Mode
2. Routes Table
The Routes dataset includes route-level transportation details, covering the source and destination cities, countries, total distance, and average transit time (in hours).
Route_ID, Source_City, Source_Country, Destination_City, Destination_Country, Distance_KM, Avg_Transit_Time_Hours
3. Warehouses Table
The Warehouses dataset provides location-level information about DHL major hubs and sortation centers.
Warehouse_ID, City, Country, Capacity_per_day, Manager_Name
4. Delivery Agents Table
The Delivery Agents dataset contains agent-level performance data, including agent ID, name, assigned zone and country, experience, and customer rating.
Agent_ID, Agent_Name, Zone, Zone_Country, Experience_Years, Avg_Rating
5. Shipment Tracking Table
The Shipments dataset includes shipment-level tracking information with timestamps for pickup and delivery, delay duration, and feedback ratings.
It captures operational data that helps analyze transit time, on-time delivery percentage, and service-level adherence across routes and agents.
Shipment_ID, Order_ID, Agent_ID, Route_ID, Warehouse_ID, Pickup_Date, Delivery_Date, Delivery_Status, Delay_Hours, Delivery_Feedback

Dataset Link: https://drive.google.com/drive/folders/1sk8JSmd229Iqkz_TUriSYMCSgLQQ6kek

