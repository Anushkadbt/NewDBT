{{
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key = 'ACCOUNT_ID',
        merge_update_columns = ['ACCOUNT_NAME','BILLING_CITY','SHIPPING_CITY','PHONE_NO']
    )
}}
SELECT  40000+row_number() OVER (ORDER BY ID) AS ACCOUNT_KEY ,ID AS ACCOUNT_ID,ACCOUNTNUMBER AS ACCOUNT_NUMBER,
        PHONE AS PHONE_NO ,NAME AS ACCOUNT_NAME,BILLINGCITY AS BILLING_CITY,
        SHIPPINGCITY AS SHIPPING_CITY
        from {{ source('stage_Account', 'ACCOUNT') }}