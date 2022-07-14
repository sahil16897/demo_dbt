{{config(materialized='table')}}

with email_table as (
    select * from {{ ref('email') }}
),

username_password as (
    select * from {{ref('username-password-recovery-code')}}
),

username as (
    select * from {{ref('username')}}
),

final as (
    select 
        username.username,
        username.id,
        username.first_name, 
        username.last_name,
        email_table.login_email,
        username_password.department,
        username_password.location,
        username_password.One_time_password,
        username_password.recovery_code,
        case 
            when username_password.department='Depot' then 'Rich'
            when username_password.department='Engineering' then 'Very Rich'
            when username_password.department='Sales' then 'Average'
        END as person_nature,
        case
            when mod(username.id, 2)=0 then 'Even ID'
            when mod(username.id, 2)<>0 then 'ODD ID'
        END as nature_of_id,
        CONCAT(username.first_name, " ", username.last_name) as full_name,
        CONCAT(username.first_name,username.last_name,"@gmail.com") as gmail_id
        
        from username
        inner join email_table
        on username.id = email_table.id
        inner join username_password
        on username.id = username_password.id
)

select * from final