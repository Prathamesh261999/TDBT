select
    cast(order_id as bigint)           as order_id,
    cast(customer_id as bigint)        as customer_id,
    cast(order_date as timestamp)      as order_ts,
    status                             as order_status,
    coupon_code,
    cast(campaign_id as bigint)        as campaign_id
from {{ source('mercurymart', 'raw_orders') }}
