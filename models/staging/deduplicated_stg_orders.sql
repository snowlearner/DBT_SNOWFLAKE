with
    deduplicated as (
        select
            *,
            row_number() over (
                partition by order_id order by order_date desc
            ) as row_num
        from {{ source('dbt_sh', 'ORDERS') }}
    )

select order_id, customer_id, order_date, amount
from deduplicated
where row_num = 1
