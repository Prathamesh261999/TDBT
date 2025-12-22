select
    cast(payment_id as bigint)         as payment_id,
    cast(order_id as bigint)           as order_id,
    cast(payment_date as timestamp)    as payment_ts,
    payment_method,
    cast(amount as numeric(12,2))      as payment_amount,
    status                             as payment_status
from {{ source('mercurymart', 'raw_payments') }}
