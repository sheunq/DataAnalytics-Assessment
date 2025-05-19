# Step 4: Subquery3 - GroupBy, Having and order by
# Group By was applied to identify customers who have both a savings and an investment plan
# N.B: sum was used inplace of count because the savings and investment columns are in 1 and 0, using count here will include 0, but 0 means no investment plan or no savings plan. so, the best function to use is sum, which will only consider the 1 not 0
# here, filtered acount with no savings plan and no investement plan but deposited using having 
# sorted total_deposits using order by

# Step 3: Subquery2 - where and Logical statement
# Here, we find customers with at least one funded savings plan AND one funded investment plan by filtering using where and logical statement

# Step 2: Subquery1- CASE
# a new column savings_investment_remark was created using conditional statement case to find funded accounts


# step 1: Joining
# In step 1, rows from three tables are joined based on a related column, savings_savingsaccount and users_customuser joined based on a id, while plans_plan and savings based on owner_id
# a new column was created for the full name of the account owner using concat function
SELECT 
    owner_id,
    name,
    SUM(savings_plan) savings_count,
    SUM(Investment_plan) investment_count,
    SUM(total_deposits) total_deposits
FROM
    (SELECT 
        name,
            owner_id,
            Investment_plan,
            savings_plan,
            total_deposits
    FROM
        (SELECT 
        name,
            owner_id,
            Investment_plan,
            savings_plan,
            CASE
                WHEN investment_plan = 0 AND savings_plan = 1 THEN 'savings'
                WHEN investment_plan = 1 AND savings_plan = 0 THEN 'investment'
                ELSE 'non'
            END AS 'savings_investment_remark',
            total_deposits
    FROM
        (SELECT 
        CONCAT(customuser.first_name, ' ', customuser.last_name) AS name,
            savings.owner_id,
            plan.is_a_fund investment_plan,
            plan.is_regular_savings savings_plan,
            savings.confirmed_amount total_deposits
    FROM
        users_customuser customuser
    JOIN savings_savingsaccount savings ON customuser.id = savings.id
    JOIN plans_plan plan ON savings.owner_id = plan.owner_id) subquery1) subquery2
    WHERE
        (savings_investment_remark = 'savings'
            OR savings_investment_remark = 'investment')
            AND total_deposits != 0) subquery3
GROUP BY name , owner_id
HAVING savings_count != 0
    AND investment_count != 0
ORDER BY total_deposits;
