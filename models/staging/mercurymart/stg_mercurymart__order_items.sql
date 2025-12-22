select
    cast(order_item_id as bigint)      as order_item_id,
    cast(order_id as bigint)           as order_id,
    cast(product_id as bigint)         as product_id,
    cast(quantity as int)              as quantity,
    cast(unit_price as numeric(10,2))  as unit_price,
    cast(quantity * unit_price as numeric(12,2))
                                      as item_gross_amount
from {{ source('mercurymart', 'raw_order_items') }}
