{{
    config(
        materialized='table'
    )
}}

WITH DIM_ACCOUNT AS
(
    SELECT * FROM {{ ref('Dim_Account') }}
),

DIM_USER AS 
(
    SELECT * FROM {{ ref('Dim_User') }}
),

DIM_DATE AS 
(
    SELECT * FROM {{ source('source_date', 'DIM_DATE') }}
),

STG_ORDER AS
(
SELECT ID ORDER_ID,OWNERID AS USER_ID,ACCOUNTID AS ACCOUNT_ID,CREATEDDATE AS CREATED_DATE,TOTALAMOUNT AS TOTAL_AMOUNT
        FROM {{ source('stage_source', 'ORDER_DETAILS') }}
)

SELECT A.ACCOUNT_KEY,U.USER_KEY,D.DATE_KEY,O.TOTAL_AMOUNT
FROM DIM_ACCOUNT A,DIM_USER U,STG_ORDER O,DIM_DATE D
WHERE 
    A.ACCOUNT_ID=O.ACCOUNT_ID AND 
    U.USER_ID=O.USER_ID AND
    CAST(O.CREATED_DATE AS DATE) = D.MY_DATE