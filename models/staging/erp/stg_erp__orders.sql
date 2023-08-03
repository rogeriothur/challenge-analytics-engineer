WITH src_order AS (
    SELECT * FROM {{ source('erp', 'orders') }}
),

orders AS (
    SELECT
        -- primary key
        order_id

        -- foreign key
        , employee_id
        , customer_id
        , ship_via AS shipper_id

        -- date
        , order_date
        , shipped_date
        , required_date

        -- strings
        , ship_name
        , ship_address
        , ship_postal_code
        , ship_city
        , ship_region
        , ship_country

        -- numeric
        , freight
    FROM
        src_order
)

SELECT * FROM orders