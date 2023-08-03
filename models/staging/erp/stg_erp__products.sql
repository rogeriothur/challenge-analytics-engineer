WITH src_product AS (
    SELECT * FROM {{ source('erp', 'products') }}
),

products AS (
    SELECT
        -- primary key
        product_id

        -- foreign key
        , supplier_id
        , category_id

        -- strings
        , product_name
        , quantity_per_unit

        -- numeric
        , unit_price
        , units_in_stock
        , units_on_order
        , reorder_level

        -- boolean
        , CASE
            WHEN discontinued = 1 THEN TRUE
            ELSE FALSE
        END AS is_discontinued
    FROM
        src_product
)

SELECT * FROM products