{{config(materialized = 'table')}}

-- This extracts the src employee table
with employees_stg_t1 as (
    select 

        json_extract_scalar(_airbyte_data, '$.businessentityid') as businessentityid,
        json_extract_scalar(_airbyte_data, '$.loginid') as loginid,
        json_extract_scalar(_airbyte_data, '$.birthdate') as birthdate,
        json_extract_scalar(_airbyte_data, '$.jobtitle') as jobtitle,
        json_extract_scalar(_airbyte_data, '$.gender') as gender,
        json_extract_scalar(_airbyte_data, '$.modifieddate') as modifieddate,
        json_extract_scalar(_airbyte_data, '$.sickleavehours') as sickleavehours,
        json_extract_scalar(_airbyte_data, '$.hiredate') as hiredate,
        json_extract_scalar(_airbyte_data, '$.rowguid') as rowguid,
        json_extract_scalar(_airbyte_data, '$.maritalstatus') as maritalstatus,
        json_extract_scalar(_airbyte_data, '$.salariedflag') as salariedflag,
        json_extract_scalar(_airbyte_data, '$.nationalidnumber') as nationalidnumber,
        json_extract_scalar(_airbyte_data, '$.currentflag') as currentflag,
        json_extract_scalar(_airbyte_data, '$.organizationnode') as organizationnode,
        json_extract_scalar(_airbyte_data, '$.vacationhours') as vacationhours,
    
    from 
        {{ source('postgres_sample_data', '_airbyte_raw_employee')}}
),

employees_stg_t2 as (
    select
        cast(businessentityid as int) businessentityid,
        loginid,
        cast(birthdate as date) as birthdate,
        jobtitle,
        gender,
        cast(modifieddate as date) as modifieddate,
        cast(sickleavehours as int) as sickleavehours,
        cast(hiredate as date) as hiredate,
        rowguid,
        maritalstatus,
        salariedflag,
        nationalidnumber,
        currentflag,
        organizationnode,
        cast(vacationhours as int) as vacationhours
    from
        employees_stg_t1
),


final as (
    select * from employees_stg_t2
)

select * from final
