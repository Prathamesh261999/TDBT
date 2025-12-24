select
    s.session_id,
    s.customer_id,
    s.session_start_ts,
    s.session_end_ts,
    s.device_type,
    s.country,

    -- Engagement metrics
    s.session_duration_seconds,
    count(e.event_id)                     as total_events,

    -- Conversion metric
    case
        when sum(case when e.event_type = 'purchase' then 1 else 0 end) > 0
        then 1 else 0
    end                                   as converted_flag

from {{ ref('stg_mercurymart__web_sessions') }} s
left join {{ ref('stg_mercurymart__web_events') }} e
    on s.session_id = e.session_id
group by
    s.session_id,
    s.customer_id,
    s.session_start_ts,
    s.session_end_ts,
    s.device_type,
    s.country,
    s.session_duration_seconds
