WITH src_customer AS (
    SELECT * FROM {{ source('erp', 'customers') }}
),

customers AS (
    SELECT
        -- primary key
        customer_id

        -- strings
        , contact_name AS customer_name
        , company_name AS customer_company_name
        , address AS customer_address
        , postal_code AS customer_postal_code
        , city AS customer_city
        , region AS customer_region
        , country AS customer_country
    FROM
        src_customer
)

SELECT * FROM customers