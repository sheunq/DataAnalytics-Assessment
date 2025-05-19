# DataAnalytics-Assessment
<img src="https://th.bing.com/th/id/R.0b82bd3f316847a00b856cbf5b79588e?rik=%2blPRZmEymS1w4w&pid=ImgRaw&r=0" alt="gcp" width="3000" height="200"/>


## 1. High-Value Customers with Multiple Products
Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

step 1: Joining
In step 1, rows from three tables are joined based on a related column, savings_savingsaccount and users_customuser joined based on a id, while plans_plan and savings based on owner_id
a new column was created for the full name of the account owner using concat function

Step 2: Subquery1- CASE
a new column savings_investment_remark was created using conditional statement case to find funded accounts

Step 3: Subquery2 - where and Logical statement
Here, we find customers with at least one funded savings plan AND one funded investment plan by filtering using where and logical statement


Step 4: Subquery3 - GroupBy, Having and order by
Group By was applied to identify customers who have both a savings and an investment plan
N.B: sum was used inplace of count because the savings and investment columns are in 1 and 0, using count here will include 0, but 0 means no investment plan or no savings plan. so, the best function to use is sum, which will only consider the 1 not 0
Here, filtered acount with no savings plan and no investement plan but deposited using having 
sorted total_deposits using order by





## 2. Transaction Frequency Analysis
Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
Task: Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)
Tables:
users_customuser
savings_savingsaccount

## 3. Account Inactivity Alert
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .
Tables:
plans_plan
savings_savingsaccount

				
## 4. Customer Lifetime Value (CLV) Estimation
Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
Account tenure (months since signup)
Total transactions
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest
