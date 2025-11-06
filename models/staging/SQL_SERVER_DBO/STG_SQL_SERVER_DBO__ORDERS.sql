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
        SHIPPING_SERVICE ,
        SHIPPING_COST ,
        ADDRESS_ID ,
        CREATED_AT ,
        PROMO_ID ,
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