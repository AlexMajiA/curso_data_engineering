{{ config(materialized='view') }}

WITH stg AS (
    SELECT *
    FROM {{ source('SQL_SERVER_DBO', 'ADDRESSES') }} 
)

SELECT
    ADDRESS_ID,               
    ZIPCODE_CLEAN,            
    COUNTRY_NAME,             
    STATE_NAME,               
    ADDRESS_NAME,             
    FIVETRAN_SYNCED           
FROM stg
WHERE not is_deleted  --Añado solo los registros activos

--Aquí no pongo md5, porque relaciono con addres_id.
--los mantengo en stg para las dimensiones analíticas.

