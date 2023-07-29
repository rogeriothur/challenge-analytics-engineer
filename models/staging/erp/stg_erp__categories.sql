WITH src_category AS (
    SELECT * FROM {{ source('erp', 'categories') }}
),

categories AS (
    SELECT
        -- primary key
        category_id

        -- strings
        , category_name	
        , description AS category_description
    FROM
        src_category
)

SELECT * FROM categories