{{ config(materialized='ephemeral') }}

select
    order_id,
    sum(payment_amount)  as total_paid_amount,
    sum(refund_amount)   as total_refunded_amount,
    sum(payment_amount) - sum(refund_amount) as net_paid_amount
from (
    -- Payments
    select
        order_id,
        payment_amount,
        0 as refund_amount
    from {{ ref('stg_mercurymart__payments') }}

    union all

    -- Refunds
    select
        order_id,
        0 as payment_amount,
        refund_amount
    from {{ ref('stg_mercurymart__refunds') }}
)
group by order_id
