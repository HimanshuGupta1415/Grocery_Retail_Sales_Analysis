-- =========================
-- UrbanCart / Grocery Retail Sales Analysis - SQL Queries
-- Table: urbancart_data
-- =========================

-- Preview rows
SELECT *
FROM urbancart_data
LIMIT 5;

-- -------------------------
-- DATA QUALITY CHECKS
-- -------------------------

-- Check sales & rating not null (quality)
SELECT 
  COUNT(*) AS total_rows,
  COUNT(sales) AS sales_non_null,
  COUNT(rating) AS rating_non_null
FROM urbancart_data;

-- -------------------------
-- BASIC KPI CHECK (Power BI cards)
-- -------------------------
SELECT
  ROUND(SUM(sales)::numeric, 2) AS total_sales,
  ROUND(AVG(sales)::numeric, 2) AS avg_sales,
  COUNT(*) AS no_of_items,
  ROUND(AVG(rating)::numeric, 2) AS avg_rating
FROM urbancart_data;

-- -------------------------
-- KPI 1: Total Sales (FIXED)
-- -------------------------
SELECT
  ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM urbancart_data;

-- KPI 2: Average Sales
SELECT
  ROUND(AVG(sales)::numeric, 2) AS avg_sales
FROM urbancart_data;

-- KPI 3: Number of Items (total rows)
SELECT
  COUNT(*) AS no_of_items
FROM urbancart_data;

-- KPI 4: Average Rating
SELECT
  ROUND(AVG(rating)::numeric, 2) AS avg_rating
FROM urbancart_data;

-- KPI 5: Total Sales by Outlet Type (dashboard table base)
SELECT
  outlet_type,
  ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM urbancart_data
GROUP BY outlet_type
ORDER BY total_sales DESC;

-- KPI 6: Total Sales by Item Type (top categories)
SELECT
  item_type,
  ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM urbancart_data
GROUP BY item_type
ORDER BY total_sales DESC
LIMIT 5;

-- KPI 7: Sales Trend by Outlet Establishment Year (line chart)
SELECT
  outlet_establishment_year,
  ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM urbancart_data
GROUP BY outlet_establishment_year
ORDER BY outlet_establishment_year;

-- KPI 8: Avg Item Visibility (used in table)
SELECT
  outlet_type,
  ROUND(AVG(item_visibility)::numeric, 4) AS avg_item_visibility
FROM urbancart_data
GROUP BY outlet_type
ORDER BY avg_item_visibility DESC;

-- -------------------------
-- DASHBOARD CHART QUERIES
-- -------------------------

-- B. Total Sales by Fat Content
SELECT
  item_fat_content,
  ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM urbancart_data
GROUP BY item_fat_content
ORDER BY total_sales DESC;

-- C. Total Sales by Item Type (full)
SELECT
  item_type,
  ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM urbancart_data
GROUP BY item_type
ORDER BY total_sales DESC;

-- D. Fat Content by Outlet for Total Sales (Advance)
SELECT
  outlet_location_type,
  item_fat_content,
  ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM urbancart_data
GROUP BY outlet_location_type, item_fat_content
ORDER BY outlet_location_type, total_sales DESC;

-- F. Percentage of Sales by Outlet Size
SELECT
  outlet_size,
  ROUND(SUM(sales)::numeric, 2) AS total_sales,
  ROUND(
    SUM(sales) * 100.0 / SUM(SUM(sales)) OVER (),
    2
  ) AS sales_percentage
FROM urbancart_data
GROUP BY outlet_size
ORDER BY total_sales DESC;

-- H. All Metrics by Outlet Type (Advance)
SELECT
  outlet_type,
  ROUND(SUM(sales)::numeric, 2) AS total_sales,
  ROUND(AVG(sales)::numeric, 2) AS avg_sales,
  COUNT(*) AS no_of_items,
  ROUND(AVG(rating)::numeric, 2) AS avg_rating,
  ROUND(AVG(item_visibility)::numeric, 4) AS avg_item_visibility
FROM urbancart_data
GROUP BY outlet_type
ORDER BY total_sales DESC;