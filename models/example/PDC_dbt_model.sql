
{{ config(
    materialized='table',
    database='DEV_DWH_TEST',
    schema='DBO'
) }}


select 
 *

from {{ ref('PDC') }}

