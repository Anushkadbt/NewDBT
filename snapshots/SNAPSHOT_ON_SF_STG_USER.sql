{% snapshot user_snapshot %}

{{
    config(
      target_database='PC_DBT_DB',
      target_schema='MODEL',
      unique_key='ID',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ source('Stage_User', 'USER') }}

{% endsnapshot %}