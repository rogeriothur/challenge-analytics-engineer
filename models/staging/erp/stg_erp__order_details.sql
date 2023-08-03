WITH src_order_detail AS (
    SELECT * FROM {{ source('erp', 'order_details') }}
),

order_details AS (
    SELECT
        -- primary key
        order_id

        -- foreign key
        , product_id

        -- numeric
        , discount
        , unit_price
        , quantity
    FROM
        src_order_detail
)

SELECT * FROM order_details