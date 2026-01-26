


SELECT
    PASSENGERID,
    NAME,
    {{ target.name }} AS env_name
FROM {{ ref('passenger_first_model') }}

