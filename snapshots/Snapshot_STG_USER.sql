{{
    config(
        materialized='ephemeral'
    )
}}

{% snapshot STG_USER %}
{{
    config(
      target_database='PC_DBT_DB',
      target_schema='MODEL',
      unique_key='ID',
      strategy='check',
      check_cols=["USERNAME","COMPANYNAME","CITY","PHONE"]
    )
}}
select ID,USERNAME,COMPANYNAME,PHONE,EMAIL,CITY
 from {{ source('stage_Account', 'USER') }}
{% endsnapshot %}