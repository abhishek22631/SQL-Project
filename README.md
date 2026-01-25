# 📦 Logistics Optimization for Delivery Routes – DHL (SQL Analytics)
## 📌 Project Overview

This project focuses on analyzing and optimizing delivery routes and logistics operations for DHL, a global logistics and courier service provider.
Using SQL-based analytics, the project identifies delivery delays, route inefficiencies, warehouse bottlenecks, and delivery agent performance issues to improve on-time delivery and operational efficiency.

The analysis simulates real-world logistics challenges arising from increasing e-commerce demand, customs delays, weather disruptions, and last-mile congestion.

## 🎯 Objectives

- Identify shipment delay patterns and root causes
- Optimize international and regional delivery routes
- Evaluate warehouse throughput and utilization
- Analyze delivery agent performance
- Generate actionable insights to improve SLA adherence and cost efficiency

## 🗂️ Dataset Description

The project uses relational datasets stored in tabular format:

### 1. Orders

- Order_ID, Customer_ID, Order_Date
- Route_ID, Warehouse_ID
- Order_Amount, Delivery_Type, Payment_Mode

### 2. Shipments

- Shipment_ID, Order_ID, Agent_ID
- Route_ID, Warehouse_ID
- Pickup_Date, Delivery_Date, Expected_Delivery_Date

Delivery_Status, Delay_Hours, Delay_Reason, Delivery_Feedback

### 3. Routes

- Route_ID
- Source_City, Source_Country
- Destination_City, Destination_Country
- Distance_KM, Avg_Transit_Time_Hours

### 4. Warehouses

- Warehouse_ID, City, Country
- Capacity_per_day, Manager_Name

### 5. Delivery Agents

- Agent_ID, Agent_Name
- Zone, Zone_Country
- Experience_Years, Avg_Rating

Dataset Link: https://drive.google.com/drive/folders/1sk8JSmd229Iqkz_TUriSYMCSgLQQ6kek

## 🛠️ Tools & Technologies

- SQL (CTEs, Window Functions, CASE, Aggregations)
- PostgreSQL / MySQL (ANSI SQL)
- Excel / Google Sheets (for visualizations)
- PowerPoint (final presentation)

## 📊 Project Tasks & Analysis
### ✅ Task 1: Data Cleaning & Preparation

- Removed duplicate orders and shipments
- Handled missing delay values using route-level averages
- Standardized date formats
- Flagged invalid delivery timelines
- Ensured referential integrity across tables

### ✅ Task 2: Delivery Delay Analysis

- Calculated actual delivery delays in hours
- Identified top 10 delayed routes
- Ranked shipments by delay within each warehouse
- Compared Express vs Standard delivery performance

### ✅ Task 3: Route Optimization Insights

- Computed average transit time and delay per route
- Calculated distance-to-time efficiency ratio
- Identified worst-performing routes
- Flagged routes with more than 20% delayed shipments

### ✅ Task 4: Warehouse Performance

- Ranked warehouses by average delay
- Compared total vs delayed shipments
- Identified warehouses exceeding global average delay
- Calculated on-time delivery percentage per warehouse

### ✅ Task 5: Delivery Agent Performance

- Ranked agents by on-time delivery percentage per route
- Identified agents below 85% on-time threshold
- Compared experience and ratings of top vs bottom agents
- Suggested training and workload balancing strategies

### ✅ Task 6: Shipment Tracking Analytics

- Retrieved latest shipment status
- Identified routes with high In Transit or Returned shipments
- Analyzed most frequent delay reasons
- Flagged shipments delayed over 120 hours

### ✅ Task 7: KPI Reporting

- Average delivery delay per source country
- On-time delivery percentage
- Average delay per route
- Warehouse utilization percentage

## 📈 Visualizations

Visualizations were created using SQL outputs and presented as:

- Bar charts for delays, routes, warehouses, and agents
- Pie / column charts for delay reasons and delivery performance
- KPI summary tables for management-level insights
- Each visualization directly maps to a specific SQL query and task.

## 💡 Key Insights

- Certain routes consistently underperform despite shorter distances
- Customs clearance and weather are the most frequent delay reasons
- Overutilized warehouses show lower on-time delivery performance
- More experienced delivery agents consistently achieve higher on-time rates

## 📌 Business Recommendations

- Redesign inefficient routes and optimize hub pairings
- Balance warehouse loads to reduce congestion
- Introduce targeted training for low-performing agents
- Implement proactive monitoring for high-risk routes and shipments


## 🚀 How to Run

- Load datasets into a SQL database
- Execute queries from logistics_analysis.sql task-wise
- Export query outputs for visualization
- Review insights and KPIs in the presentation

---
Author: Abhishek Chakraborty
- 📧 Email: abhishekchakraborty22@yahoo.com
- 🔗 GitHub: https://github.com/abhishek22631
