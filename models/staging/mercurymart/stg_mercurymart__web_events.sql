select
    cast(event_id as bigint)                 as event_id,
    cast(session_id as bigint)               as session_id,
    cast(event_timestamp as timestamp)       as event_ts,
    event_type,
    page_url,
    cast(product_id as bigint)               as product_id
from {{ source('mercurymart', 'raw_web_events') }}
