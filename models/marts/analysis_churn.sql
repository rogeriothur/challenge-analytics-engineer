WITH base as (
    SELECT
        customer_fk
        , order_id
        , order_date
    FROM
        {{ ref("fct_sales") }}
    GROUP BY
        customer_fk, order_id, order_date
    ORDER BY
        order_date
),

-- add column containing customer's previous order date
add_column AS (
    SELECT
        base.*
        , LAG(order_date) OVER (PARTITION BY customer_fk ORDER BY order_date) AS last_order_date
    FROM base
),
-- add column that contains how many days the customer went without buying from one order to another
churn_informations AS (
    SELECT
        *
        , DATE_DIFF(order_date, last_order_date, day) AS days_without_buying
    FROM
        add_column
    ORDER BY
        order_date
)

SELECT * FROM churn_informations