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


SELECT 
    id,
    name,
    tenure_months,
    Total_transaction total_transactions,
    (Total_transaction / tenure_months) * 12 * avg_profit_per_transaction estimated_clv
FROM
    (SELECT 
        id,
            name,
            Total_transaction,
            Total_transaction_profit / total_transaction avg_profit_per_transaction,
            last_transaction_month - month_account_created tenure_months
    FROM
        (SELECT 
        id,
            name,
            COUNT(name) Total_transaction,
            SUM(confirmed_amount * 0.001) Total_transaction_profit,
            MIN(created_on_customuser_month) month_account_created,
            MAX(transaction_date_month) last_transaction_month
    FROM
        (SELECT 
        customuser_id id,
            created_on_customuser,
            MONTH(created_on_customuser) created_on_customuser_month,
            name,
            transaction_date,
            MONTH(transaction_date) transaction_date_month,
            confirmed_amount
    FROM
        (SELECT 
        savings_id,
            customuser_id,
            created_on_customuser,
            CONCAT(first_name, ' ', last_name) name,
            transaction_date,
            confirmed_amount
    FROM
        (SELECT 
        savings.transaction_date,
            savings.transaction_reference,
            savings.transaction_status,
            savings.transaction_type_id,
            savings.created_on savings_created_on,
            savings.owner_id,
            savings.plan_id,
            savings.id savings_id,
            savings.maturity_start_date,
            savings.maturity_end_date,
            savings.amount,
            savings.confirmed_amount,
            savings.deduction_amount,
            savings.new_balance,
            customuser.id customuser_id,
            customuser.date_joined,
            customuser.created_on customuser_created_on,
            customuser.first_name,
            customuser.last_name,
            customuser.created_on created_on_customuser
    FROM
        savings_savingsaccount savings
    JOIN users_customuser customuser ON savings.owner_id = customuser.id) subquery1) subquery2) subquery3
    GROUP BY id , name) subquery4) subquery5
    Order by estimated_clv desc;
