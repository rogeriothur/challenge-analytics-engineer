WITH src_employee AS (
    SELECT * FROM {{ source('erp', 'employees') }}
),

employees AS (
    SELECT
        -- primary key
        employee_id

        -- foreign key
        , reports_to AS manager_id

        -- strings
        , CAST((first_name || ' ' || last_name) AS string) AS employee_name	
        , title AS employee_title
        , address AS employee_address
        , city AS employee_city
        , region AS employee_region
        , postal_code AS employee_postal_code
        , country AS employee_country
        , notes AS employee_notes

        -- date & timestamp
        , birth_date AS employee_birth_date
        , hire_date	AS employee_hire_date
    FROM
        src_employee
)

SELECT * FROM employees