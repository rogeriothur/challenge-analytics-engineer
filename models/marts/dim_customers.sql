WITH customers AS (
    SELECT * FROM {{ ref('stg_erp__customers') }}
),

dim_customers AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} AS customer_sk
        , *
    FROM
        customers
)

SELECT * FROM dim_customers