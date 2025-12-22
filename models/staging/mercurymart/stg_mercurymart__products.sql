select
    cast(product_id as bigint)         as product_id,
    product_name,
    category,
    brand,
    cast(unit_price as numeric(10,2))  as unit_price,
    cast(supplier_id as bigint)        as supplier_id
from {{ source('mercurymart', 'raw_products') }}
