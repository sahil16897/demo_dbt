{{ config(materialized='table') }}

with source_table as (
    select * from {{ source('sample_source', 'sample') }}
),

final as (
    select * from source_table where int64_field_3 = {{var('value')}}
)


select * from final