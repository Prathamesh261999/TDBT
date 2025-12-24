select
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    p.supplier_id,

    -- Product status (derived)
    case
        when p.unit_price > 0 then 'Active'
        else 'Inactive'
    end as product_status,

    -- Price bucket
    case
        when p.unit_price < 20 then 'Low'
        when p.unit_price between 20 and 100 then 'Medium'
        else 'High'
    end as price_bucket,

    p.unit_price
from {{ ref('stg_mercurymart__products') }} p
