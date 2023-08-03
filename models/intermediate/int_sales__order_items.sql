WITH orders AS (
    SELECT * FROM {{ ref('stg_erp__orders') }}
),

order_details AS (
    SELECT * FROM {{ ref('stg_erp__order_details') }}
),

int_sales AS (
    SELECT
        -- primary key
        orders.order_id

        -- foreign key
        , orders.employee_id
        , orders.customer_id
        , orders.shipper_id
        , order_details.product_id

        -- date
        , orders.order_date
        , orders.shipped_date
        , orders.required_date

        -- numeric
        , orders.freight
        , order_details.discount
        , order_details.unit_price
        , order_details.quantity

        -- strings
        , orders.ship_name
        , orders.ship_address
        , orders.ship_postal_code
        , orders.ship_city
        , orders.ship_region
        , orders.ship_country

    FROM
        order_details
    LEFT JOIN
        orders ON order_details.order_id = orders.order_id
)
SELECT * FROM int_sales