{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

select
    o.order_id,
    date(o.order_ts)                     as order_date,
    o.customer_id,
    o.campaign_id,
    o.coupon_code,
    o.order_status,

    -- Revenue metrics
    sum(oi.item_gross_amount)            as gross_revenue,
    sum(oi.item_gross_amount)
      - coalesce(p.net_paid_amount, 0)   as discount_amount,
    coalesce(p.net_paid_amount, 0)       as net_sales,

    -- Payment status
    case
        when p.net_paid_amount > 0 then 'Paid'
        else 'Unpaid'
    end                                  as payment_status

from {{ ref('stg_mercurymart__orders') }} o
left join {{ ref('stg_mercurymart__order_items') }} oi
    on o.order_id = oi.order_id
left join {{ ref('int_mercurymart__order_payment_summary') }} p
    on o.order_id = p.order_id

{% if is_incremental() %}
where o.order_ts > (
    select max(order_date) from {{ this }}
)
{% endif %}

group by
    o.order_id,
    order_date,
    o.customer_id,
    o.campaign_id,
    o.coupon_code,
    o.order_status,
    p.net_paid_amount
