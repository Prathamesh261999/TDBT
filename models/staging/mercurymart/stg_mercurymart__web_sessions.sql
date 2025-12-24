select
    cast(session_id as bigint)               as session_id,
    cast(customer_id as bigint)              as customer_id,
    cast(session_start_time as timestamp)    as session_start_ts,
    cast(session_end_time as timestamp)      as session_end_ts,
    device_type,
    country,
    datediff(
        second,
        cast(session_start_time as timestamp),
        cast(session_end_time as timestamp)
    )                                        as session_duration_seconds
from {{ source('mercurymart', 'raw_web_sessions') }}
