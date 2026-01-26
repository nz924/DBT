-- Configuration du modèle : materialized peut être 'table', 'view' ou 'incremental'
{{ config(
    materialized='table'
) }}


select *,
    CASE 
        WHEN PCLASS > 3 THEN TRUE
        ELSE FALSE
    END AS pclass_gt_3,
    (SIBSP + PARCH) AS family_size,

    -- 3️⃣ Champ calculé : Adult/Child
    CASE 
        WHEN AGE >= 18 THEN 'Adult'
        ELSE 'Child'
    END AS age_group,

    -- 4️⃣ Champ calculé : Indicateur de survie (booléen)
    CASE 
        WHEN SURVIVED = 1 THEN TRUE
        ELSE FALSE
    END AS survived_flag,

    -- 5️⃣ Champ calculé : Tarif moyen par membre de la famille (évite division par zéro)
    CASE 
        WHEN (SIBSP + PARCH + 1) > 0 THEN FARE / (SIBSP + PARCH + 1)
        ELSE FARE
    END AS fare_per_person,

    -- 6️⃣ Champ calculé : Indicateur embarquement valide
    CASE
        WHEN EMBARKED IN ('C','Q','S') THEN TRUE
        ELSE FALSE
    END AS embarked_valid,
    {{ age_group('AGE') }} AS age_group1,
     {{ age_group('AGE') }} AS age_group2,
     '{{ target.name }}' AS env_name
from {{ ref('passenger_first_model') }}

{% if target.name == 'default' %}
WHERE PASSENGERID = 8
{% else %}
WHERE PASSENGERID > 1000
{% endif %}
