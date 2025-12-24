select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.country,
    c.segment,
    c.signup_ts,

    -- First order date
    min(o.order_ts)                       as first_order_ts,

    -- Lifetime metrics
    count(distinct o.order_id)            as lifetime_orders,
    sum(coalesce(p.net_paid_amount, 0))   as lifetime_net_spend,

    -- Loyalty tier
    case
        when sum(coalesce(p.net_paid_amount, 0)) >= 5000 then 'Platinum'
        when sum(coalesce(p.net_paid_amount, 0)) >= 2000 then 'Gold'
        when sum(coalesce(p.net_paid_amount, 0)) >= 500  then 'Silver'
        else 'Bronze'
    end                                   as loyalty_tier

from {{ ref('stg_mercurymart__customers') }} c
left join {{ ref('stg_mercurymart__orders') }} o
    on c.customer_id = o.customer_id
left join {{ ref('int_mercurymart__order_payment_summary') }} p
    on o.order_id = p.order_id
group by
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.country,
    c.segment,
    c.signup_ts
