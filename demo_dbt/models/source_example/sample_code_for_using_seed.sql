{{ config(materialized='table')}}

with source_table as (
    select * from {{ source('sample_source', 'sample') }}
),

sample_seed as (
    select * from {{ ref('sample_seed_csv')}}
),

final as (
    select
        source_table.string_field_1,
        sample_seed.footnote

        from source_table
        inner join sample_seed
        on source_table.int64_field_0 = sample_seed.number
)

select * from final