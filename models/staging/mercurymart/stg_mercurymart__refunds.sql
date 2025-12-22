select
    cast(refund_id as bigint)          as refund_id,
    cast(payment_id as bigint)         as payment_id,
    cast(order_id as bigint)           as order_id,
    cast(refund_date as timestamp)     as refund_ts,
    cast(amount as numeric(12,2))      as refund_amount,
    reason
from {{ source('mercurymart', 'raw_refunds') }}
