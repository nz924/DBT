
select *
from {{ source('raw1', 'PASSENGER') }}
