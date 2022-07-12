{{ config(materialized='table') }}

with source_table as (
    select * from {{ source('sample_source', 'sample') }}
),

final as (
    select * from source_table where string_field_2='Carlos Soltero'
)


select * from final