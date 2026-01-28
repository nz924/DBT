-- tests/allowed_sex.sql
SELECT *
FROM {{ ref('passenger_model') }}
WHERE NOT  ({{ allowed_values('SEX', ['male', 'female']) }})
