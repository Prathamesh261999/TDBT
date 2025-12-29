select
    *,
    case
        when lifetime_orders > 0
        then lifetime_net_spend / lifetime_orders
        else 0
    end as avg_order_value
from {{ ref('dim_customers') }}
