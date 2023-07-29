WITH employees AS (
    SELECT * FROM {{ ref('stg_erp__employees') }}
),

self_join AS (
    SELECT
        -- primary key
        employees.employee_id

        -- foreign key
        , employees.manager_id

        -- strings
        , employees.employee_name
        , manager.employee_name AS manager_name
        , employees.employee_address
        , employees.employee_city
        , employees.employee_region
        , employees.employee_postal_code
        , employees.employee_country
        , employees.employee_notes

        -- date & timestamp
        , employees.employee_birth_date
        , employees.employee_hire_date
    FROM
        employees
    LEFT JOIN
        employees AS manager ON employees.manager_id = manager.employee_id
),

dim_employees AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['employee_id']) }} AS employee_sk
        , *
    FROM
        self_join
)

SELECT * FROM dim_employees