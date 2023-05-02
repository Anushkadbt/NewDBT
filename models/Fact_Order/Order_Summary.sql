
{{
    config(
        materialized='table'
    )
}}

WITH FACT_ORDER AS
(
    SELECT * FROM {{ ref('Fact_Order') }}
)

SELECT ACCOUNT_KEY,SUM(TOTAL_AMOUNT) AS TOTAL_AMOUNT
FROM FACT_ORDER 
GROUP BY ACCOUNT_KEY
ORDER BY ACCOUNT_KEY