{{
  config(
    materialized='view'
  )
}}

WITH FUENTE_PRINCIPAL AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'PROMOS') }}
    ),

promos_casted AS (
    SELECT
         md5(lower(cast(PROMO_ID as varchar))) AS PROMO_HASH,
         trim(PROMO_ID) AS PROMO_NAME,
	     CAST(DISCOUNT AS FLOAT) AS DISCOUNT,
	     STATUS,
	     _FIVETRAN_DELETED,
	     CONVERT_TIMEZONE('Europe/Madrid', _FIVETRAN_SYNCED::TIMESTAMP_NTZ) AS FIVETRAN_SYNCED
         FROM FUENTE_PRINCIPAL
         
    UNION ALL

    SELECT
    --Añado fila sin promo
        MD5('Sin_Promo') AS PROMO_HASH,
        'Sin_Promo' AS PROMO_NAME,
        '{{ var('num_undefined')}}' AS DISCOUNT,
        'Inactive' as STATUS,
        null AS _FIVETRAN_DELETED,
        CURRENT_TIMESTAMP AS FIVETRAN_SYNCED

    )

SELECT * FROM promos_casted