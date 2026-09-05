-- ============================================================
-- Customer Churn Analysis — SQL Queries
-- Database table: customers  (loaded from Telco-Customer-Churn.csv)
-- ============================================================

-- ---------- Customer Overview ----------

-- Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Number of churned customers
SELECT COUNT(*) AS churned_customers
FROM customers
WHERE Churn = 'Yes';

-- ---------- Demographics ----------

-- Customers by gender
SELECT gender, COUNT(*) AS customer_count
FROM customers
GROUP BY gender;

-- Number of senior citizens
SELECT COUNT(*) AS senior_citizen_count
FROM customers
WHERE SeniorCitizen = 1;

-- ---------- Contract & Tenure ----------

-- Average tenure for churned vs non-churned customers
SELECT Churn, AVG(tenure) AS avg_tenure
FROM customers
GROUP BY Churn;

-- Number of customers by contract type
SELECT Contract, COUNT(*) AS customer_count
FROM customers
GROUP BY Contract;

-- ---------- Internet Service & Charges ----------

-- Average MonthlyCharges by InternetService category
SELECT InternetService, AVG(MonthlyCharges) AS avg_monthly_charges
FROM customers
GROUP BY InternetService;

-- Total TotalCharges by PaymentMethod
SELECT PaymentMethod, SUM(TotalCharges) AS total_charges_sum
FROM customers
GROUP BY PaymentMethod;

-- ---------- Churn Drivers ----------

-- Churn rate by contract type
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- Churn rate by internet service type
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;

-- Churn rate by OnlineSecurity (Yes vs No)
SELECT
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY OnlineSecurity
ORDER BY churn_rate_pct DESC;

-- ---------- Advanced Aggregation ----------

-- Top 5 customer segments (Contract x InternetService) by churn rate
-- (restricted to segments with a reasonably sized customer base)
SELECT
    Contract,
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY Contract, InternetService
HAVING COUNT(*) >= 30
ORDER BY churn_rate_pct DESC
LIMIT 5;
