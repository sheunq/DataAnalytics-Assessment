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
SELECT 
    frequency_category,
    COUNT(avg_transactions_per_month) customer_count,
    AVG(avg_transactions_per_month) avg_transactions_per_month
FROM
    (SELECT 
        CASE
                WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
                WHEN
                    avg_transactions_per_month >= 3
                        AND avg_transactions_per_month <= 9
                THEN
                    'Medium Frequency'
                WHEN avg_transactions_per_month <= 2 THEN 'Low Frequency'
                ELSE 'Low Frequency'
            END AS frequency_category,
            avg_transactions_per_month
    FROM
        (SELECT 
        name,
            transactions_month,
            ROUND(COUNT(transactions_day) / COUNT(DISTINCT transactions_day), 1) avg_transactions_per_month
    FROM
        (SELECT 
        CONCAT(first_name, ' ', last_name) name,
            transaction_date,
            MONTH(transaction_date) transactions_month,
            DAY(transaction_date) transactions_day
    FROM
        (SELECT 
        customuser.id,
            customuser.first_name,
            last_name,
            savings.confirmed_amount,
            savings.transaction_date,
            savings.owner_id,
            plan_id
    FROM
        users_customuser customuser
    JOIN savings_savingsaccount savings ON customuser.id = savings.owner_id) subquery1) subquery2
    GROUP BY name , transactions_month) subquery3) subquery4
GROUP BY frequency_category;