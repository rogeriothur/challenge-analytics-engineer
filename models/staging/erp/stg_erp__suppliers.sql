WITH src_supplier AS (
    SELECT * FROM {{ source('erp', 'suppliers') }}
),

suppliers AS (
    SELECT
        -- primary key
        supplier_id

        -- strings
        , contact_name AS supplier_name
        , company_name AS supplier_company_name
        , address AS supplier_address
        , postal_code AS supplier_postal_code
        , city AS supplier_city
        , region AS supplier_region
        , country AS supplier_country
    FROM
        src_supplier
)

SELECT * FROM suppliers