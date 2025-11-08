with pay as (
    select order_id, sum(payment_value) as total_paid
    from {{ ref('stg_olist_payments') }}
    group by order_id
)
select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_ts,
    o.delivered_customer_ts,
    p.total_paid
from {{ ref('stg_olist_orders') }} o
left join pay p using (order_id)