WITH products AS (
    SELECT * FROM {{ ref('stg_erp__products') }}
),

suppliers AS (
    SELECT * FROM {{ ref('stg_erp__suppliers') }}
),

categories AS (
    SELECT * FROM {{ ref('stg_erp__categories') }}
),

dim_products AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_sk
        , products.product_id
        , products.supplier_id
        , products.category_id

        -- strings
        , products.product_name
        , products.quantity_per_unit

        , categories.category_name
        , categories.category_description

        , suppliers.supplier_name
        , suppliers.supplier_company_name
        , suppliers.supplier_address
        , suppliers.supplier_postal_code
        , suppliers.supplier_city
        , suppliers.supplier_region
        , suppliers.supplier_country

        -- numeric
        , products.unit_price
        , products.units_in_stock
        , products.units_on_order
        , products.reorder_level

        -- boolean
        , products.is_discontinued
    FROM
        products
    LEFT JOIN
        suppliers ON products.supplier_id = suppliers.supplier_id
    LEFT JOIN
        categories ON products.category_id = categories.category_id
)

SELECT * FROM dim_products

