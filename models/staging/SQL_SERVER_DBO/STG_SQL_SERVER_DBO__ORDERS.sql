{{
  config(
    materialized='view'
  )
}}

WITH FUENTE_PRINCIPAL AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'ORDERS') }}
    ),

ORDERS_CASTED AS (
    SELECT
        ORDER_ID ,
        SHIPPING_SERVICE 
           CASE 
                WHEN STATUS = 'preparacion' AND (SHIPPING_SERVICE IS NULL OR SHIPPING_SERVICE = '') 
                    THEN 'No_shipping_service'
                ELSE SHIPPING_SERVICE
            END AS SHIPPING_SERVICE
        cast(SHIPPING_COST as decimal (12,2)) AS SHIPPING_COST ,
        ADDRESS_ID ,
        CREATED_AT ,
        md5(cast(PROMO_ID as varchar)) AS PROMO_ID,
             PROMO_ID AS PROMO_NAME,
        ESTIMATED_DELIVERY_AT ,
        ORDER_COST ,
        USER_ID ,
        ORDER_TOTAL ,
        DELIVERED_AT 
        TRACKING_ID ,
        STATUS ,
        _FIVETRAN_DELETED ,
        _FIVETRAN_SYNCED ,

    FROM FUENTE_PRINCIPAL
    )

SELECT * FROM FUENTE_PRINCIPAL