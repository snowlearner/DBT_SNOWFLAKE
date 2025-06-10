
WITH ranked_orders AS (
    SELECT 
        ORDER_ID,
        CUSTOMER_ID,
        ORDER_DATE,
        AMOUNT,
        ROW_NUMBER() OVER (ORDER BY AMOUNT DESC) AS rank
    FROM {{ ref('stg_orders') }}
)

SELECT 
    ORDER_ID,
    CUSTOMER_ID,
    ORDER_DATE,
    AMOUNT
FROM ranked_orders
WHERE rank <= 2