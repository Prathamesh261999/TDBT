{% snapshot snap_customers %}

{{
    config(
      target_schema='snapshots',
      unique_key='customer_id',
      strategy='check',
      check_cols=['email', 'country', 'segment']
    )
}}

select
    customer_id,
    email,
    country,
    segment
from {{ ref('dim_customers') }}

{% endsnapshot %}
