select
    cast(customer_id as bigint)        as customer_id,
    first_name,
    last_name,
    lower(email)                       as email,
    cast(signup_date as timestamp)     as signup_ts,
    country,
    segment
from {{ source('mercurymart', 'raw_customers') }}
