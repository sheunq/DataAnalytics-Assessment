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

SELECT 
    plan_id,
    owner_id,
    type,
    MAX(transaction_date) last_transaction_date,
    DATEDIFF(MAX(transaction_date),
            MIN(transaction_date)) inactivity_days
FROM
    (SELECT 
        plan_id,
            owner_id,
            CASE
                WHEN is_a_fund = 1 AND is_regular_savings = 0 THEN 'investments'
                WHEN is_a_fund = 0 AND is_regular_savings = 1 THEN 'savings'
                ELSE 'non'
            END AS type,
            confirmed_amount,
            transaction_date
    FROM
        (SELECT 
        owner_id,
            is_a_fund,
            is_regular_savings,
            owner_id_savings,
            plan_id_savings plan_id,
            confirmed_amount,
            transaction_date
    FROM
        (SELECT 
        owner_id,
            is_a_fund,
            is_regular_savings,
            owner_id_savings,
            plan_id_savings,
            confirmed_amount,
            transaction_date
    FROM
        (SELECT 
        plan.id,
            plan.owner_id,
            plan.is_a_fund,
            plan.is_regular_savings,
            savings.owner_id owner_id_savings,
            savings.plan_id plan_id_savings,
            savings.confirmed_amount,
            savings.transaction_date
    FROM
        plans_plan plan
    JOIN savings_savingsaccount savings ON plan.owner_id = savings.owner_id) subqeury1
    WHERE
        transaction_date BETWEEN DATE_SUB((SELECT 
                MAX(transaction_date)
            FROM
                savings_savingsaccount), INTERVAL 1 YEAR) AND (SELECT 
                MAX(transaction_date)
            FROM
                savings_savingsaccount)) subqeury2
    WHERE
        is_a_fund = 1 OR is_regular_savings = 1) subqeury3
    WHERE
        confirmed_amount = 0) subqeury4
GROUP BY plan_id , owner_id , type;