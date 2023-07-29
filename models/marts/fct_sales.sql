WITH customers AS (
    SELECT * FROM {{ ref('dim_customers') }}
),

employees AS (
    SELECT * FROM {{ ref('dim_employees') }}
),

products AS (
    SELECT * FROM {{ ref('dim_products') }}
),

order_items AS (
    SELECT * FROM {{ ref('int_sales__order_items') }}
),

int_fct_vendas AS (
    SELECT
        order_items.order_id

        , customers.customer_sk AS customer_fk
        , employees.employee_sk AS employee_fk
        , products.product_sk AS product_fk

        , order_items.shipper_id

        -- date
        , order_items.order_date
        , order_items.shipped_date
        , order_items.required_date

        -- numeric
        , order_items.freight
        , order_items.discount
        , order_items.unit_price
        , order_items.quantity

        -- strings
        , order_items.ship_name
        , order_items.ship_address
        , order_items.ship_postal_code
        , order_items.ship_city
        , order_items.ship_region
        , order_items.ship_country

        , customers.customer_name
        , employees.employee_name
        , employees.manager_name
        , products.product_name
        , products.category_name
        , products.supplier_name
        , products.is_discontinued
    FROM
       order_items
    LEFT JOIN
        customers ON order_items.customer_id = customers.customer_id
    LEFT JOIN
        employees ON order_items.employee_id = employees.employee_id
    LEFT JOIN
        products ON order_items.product_id = products.product_id
),

fct_sales AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['order_id', 'product_fk']) }} AS sale_sk
        , *
        , unit_price * quantity AS gross_total
        , (1 - discount) * unit_price * quantity AS net_total
        , CASE
            WHEN discount > 0 THEN TRUE
            WHEN discount = 0 THEN FALSE
            ELSE FALSE
        END AS is_discount
    FROM
        int_fct_vendas
)

SELECT * FROM fct_sales