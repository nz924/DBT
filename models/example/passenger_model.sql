-- Configuration du modèle : materialized peut être 'table', 'view' ou 'incremental'
{{ 
    config(
        materialized = 'table'
    ) 
}}

select *
from {{ source('raw1', 'PASSENGER') }}

