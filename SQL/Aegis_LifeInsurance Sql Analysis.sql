create database Aegislife_Insurance_Analysis;
use Aegislife_Insurance_Analysis;

select * from policydetail_cleaned;

-- Customer Master 
CREATE TABLE customer_master (
    customer_id VARCHAR(20) PRIMARY KEY,
    full_name VARCHAR(100),
    age INT,
    gender VARCHAR(20),
    marital_status VARCHAR(20),
    occupation VARCHAR(30),
    region VARCHAR(30),
    smoking_status VARCHAR(10),
    pre_existing_illness VARCHAR(10),
    risk_score DECIMAL(5,2),
    date_joined DATE
);

-- Policy Details
CREATE TABLE policy_details (
    policy_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    product_type VARCHAR(30),
    coverage_amount DECIMAL(15,2),
    annual_premium DECIMAL(15,2),
    policy_start_date DATE,
    policy_end_date DATE,
    agent_id VARCHAR(20),
    status VARCHAR(20),

    FOREIGN KEY (customer_id)
        REFERENCES customer_master(customer_id)
);


-- Agent Info 
CREATE TABLE agent_info (
    agent_id VARCHAR(20) PRIMARY KEY,
    region VARCHAR(30),
    join_date DATE,
    total_policies_sold INT,
    lapsed_policies INT,
    avg_premium_sold DECIMAL(15,2),
    fraud_association INT
);

ALTER TABLE policy_details
ADD CONSTRAINT fk_policy_agent
FOREIGN KEY (agent_id)
REFERENCES agent_info(agent_id);


-- Customer Claims
CREATE TABLE claim_history (
    claim_id VARCHAR(20) PRIMARY KEY,
    policy_id VARCHAR(20),
    claim_date DATE,
    claim_amount DECIMAL(15,2),
    claim_status VARCHAR(20),
    claim_type VARCHAR(30),
    fraud_flag VARCHAR(10),
    days_to_process INT,

    FOREIGN KEY (policy_id)
        REFERENCES policy_details(policy_id)
); 

ALTER TABLE claimedhistory_cleaned
CHANGE COLUMN `ï»¿claim_id` claim_id VARCHAR(20);

-- Customer Feedback
 CREATE TABLE customer_feedback_surveys (
    feedback_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    date_submitted DATE,
    feedback_text TEXT,
    satisfaction_score INT,
    contacted_agent VARCHAR(10),
    referred_claim VARCHAR(10),

    FOREIGN KEY (customer_id)
        REFERENCES customer_master(customer_id)
);

SHOW TABLES;

Describe customer_master;
Describe policy_details;
Describe claim_history;
Describe customer_feedback_surveys;
Describe agent_info;



SELECT COUNT(*) AS customer_rows
FROM customermaster_cleaned;

SELECT COUNT(*) AS policy_rows
FROM policydetail_cleaned;

SELECT COUNT(*) AS claim_rows
FROM claimedhistory_cleaned;

SELECT COUNT(*) AS agent_rows
FROM agentinfo_cleaned;

SELECT COUNT(*) AS feedback_rows
FROM customerfeedback_cleaned;


-- Checking duplicate values in tabular data
SELECT customer_id, COUNT(*)
FROM customer_master
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT policy_id, COUNT(*)
FROM policy_details
GROUP BY policy_id
HAVING COUNT(*) > 1;

SELECT claim_id, COUNT(*)
FROM claim_history
GROUP BY claim_id
HAVING COUNT(*) > 1;

SELECT agent_id, COUNT(*)
FROM agent_info
GROUP BY agent_id
HAVING COUNT(*) > 1;


-- Customers by Gender Analysis

SELECT
gender,
COUNT(*) AS Total_Customers
FROM customermaster_cleaned
GROUP BY gender;


-- Customers by Region Analysis

SELECT
region,
COUNT(*) AS Total_Customers
FROM customermaster_cleaned
GROUP BY region
ORDER BY Total_Customers DESC;


-- Customer by occupation Analysis

SELECT
occupation,
COUNT(*) AS Total_Customers
FROM customermaster_cleaned
GROUP BY occupation
ORDER BY Total_Customers DESC; 


-- Average Risk Score by region Analysis

SELECT
region,
ROUND(AVG(risk_score),2) AS Average_Risk
FROM customermaster_cleaned
group by region
order by average_risk desc;


-- Smoking vs Non-Smoking Customers status analysis

SELECT 
Smoking_status,
Count(*) as Total_Customers 
From customermaster_cleaned
Group BY smoking_status;


-- Customers with Pre-existing Illness Analysis

SELECT
pre_existing_illness,
COUNT(*) AS Total_Customers
FROM customermaster_cleaned
GROUP BY pre_existing_illness;


-- Policies by Status Analysis

select
status,
count(*) as Total_Policies
From policydetail_cleaned
Group By status;


-- Policies by Product Type Analysis

 select
 product_type,
 count(*) as Total_policies
 from policydetail_cleaned
 Group By product_type
 order by total_policies desc;
 
 
 -- Total Premium Collected by Product Type

Select
product_type,
sum(annual_premium) as total_premium
from policydetail_cleaned
group by product_type
order by total_premium desc;


-- Average Premium 

Select
Round(avg(annual_premium),2) as Average_premium
from policydetail_cleaned;


-- Total Coverage Amount

Select
sum(coverage_amount) as Total_Coverage
from policydetail_cleaned;


--  Average Coverage Amount

select
product_type,
round(avg(coverage_amount),2) as average_coverage
from policydetail_cleaned
group by product_type;


-- Claims Status Analysis

Select
claim_status,
count(*) as Total_claims
from claimedhistory_cleaned
Group by claim_status;


-- Fraud Cases Analysis

select
fraud_flag,
count(*) as total_cases
from claimedhistory_cleaned
Group By fraud_flag;


-- Total Claim Amount by status

Select
claim_status,
sum(claim_amount) as total_claim_amount
from claimedhistory_cleaned
Group by claim_status;


-- Average Satisfaction Score

select
round(avg(satisfaction_score),2) as Avg_satisfaction
From customerfeedback_cleaned;


-- Custmer Satisfaction Analysis

select
satisfaction_score,
count(*) as customers
from customerfeedback_cleaned
group by satisfaction_score
order by satisfaction_score;


-- Average claim Processing Days

SELECT
    ROUND(AVG(days_to_process),2) AS average_processing_days
FROM claimedhistory_cleaned;


-- Top 10 Highest Premium Policies

select 
policy_id,
annual_premium
from policydetail_cleaned
order by annual_premium desc
limit 10;

show tables;

-- Top 10 highest claims

SELECT
    claim_id,
    policy_id,
    claim_amount
FROM claimedhistory_cleaned
ORDER BY claim_amount DESC
LIMIT 10;



-- Agent-wise Policies Sold 

select
agent_id,
count(*) as Policies_sold
from policydetail_cleaned
group by agent_id
order by policies_sold desc;


-- Agent-wise premium Collected

select 
agent_id,
sum(annual_premium) as premium_collected
from policydetail_cleaned
group by agent_id
order by premium_collected desc;

select * from agentinfo_cleaned;
























