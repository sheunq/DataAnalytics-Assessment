# DataAnalytics-Assessment
<img src="https://th.bing.com/th/id/R.0b82bd3f316847a00b856cbf5b79588e?rik=%2blPRZmEymS1w4w&pid=ImgRaw&r=0" alt="gcp" width="3000" height="200"/>


## 1. High-Value Customers with Multiple Products
<p> Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
	
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.</p>

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

# step 5: subquery 4 - Group By and Count function 
# In Step 5, The frequency category was grouped using group by and counted using count function to know the numbers of customer that falls in this category 

# step 4: subquery 3 - CASE Statement
# In step 4: Case statement was utilized to categorized transaction frequency in Low, Medium and High

# step 3: subquery 2 - Group By, Count, Round and Distinct
# In Step 3, In order to get the avg_transactions_per_month, name and monthly transaction was grouped using group by
# Afterward,  avg_transactions_per_month was extrated by suming all the transactions performed  in a day for days the transaction was performed using Count, divided by totals days transaction was made  in a month using distinct count

# step 2: subquery 1 - Concat, Day and Month
# In step 2, the account name was concatinate and two new columns day of the transactions and month of the transactions was extrate from transaction_date

# step 1: Joining
# In step 1, rows from two tables are joined based on a related column, savings_savingsaccount and users_customuser joined based on a id
# a new column was created for the full name of the account owner using concat function



## 3. Account Inactivity Alert
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .

# step 5: Subquery4 -  Group By, Max, min and Datediff
# In Step 5, plan_id and owner_id was grouped using group by extract the last transaction date using max transact date by owner_id and plan_id. Also, account Inactive_days was generated using datediff function to dedect the inactive duration. 

# step 4: Subquery3 -  where, Case
# In step 4, filter using where to extract the inactive account.Also, the accout was segmented into savings and invesment using case statement 


# step 3: Subquery2 -  where
# In step 3, filter using where to extract savings or investments.

# step 2: Subquery1 - query in query - where, DATE_SUB and interval
# In Step 2, filter using where to extract customers account in the last one year. 

# step 1: Joining
# In step 1, rows from two tables are joined based on a related column, savings_savingsaccount and plans_plan joined based on a owner_id

				
## 4. Customer Lifetime Value (CLV) Estimation
Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
Account tenure (months since signup)
Total transactions
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest

# step 5: Subquery4 - Order By
# in Step 5, estimated_clv was extracted using this formular (Total_transaction / tenure_months) * 12 * avg_profit_per_transaction and sorted in descending order using order by

# step 4: Subquery3 - functions(Count, sum, Max and Min) and Group By 
# In Step 4: Four new columns was created by grouping  account names, extrated  Total_transaction_profit  by suming (confirmed_amount * 0.001), month_account_created sing min function and last_transaction_month using max on transaction_date 

# step 3: Subquery2 - Month
# In step 3, two colums was created. created_on_customuser_month, the month customer created account and  transaction_date_month, the month transaction was performed

# step 2: Subquery1 - Concat function
# In step 2, a new column was created for the full name of the account owner using concat function

# step 1: Joining
# In step 1, rows from two tables are joined based on a related column, savings_savingsaccount and users_customuser joined based on a id
