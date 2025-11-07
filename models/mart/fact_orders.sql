with payments as (
  select order_id, sum(amount) as total_amount
  from {{ ref('stg_payments') }}
  group by order_id
)
select
  o.order_id,
  o.customer_id,
  o.order_date,
  o.status,
  coalesce(p.total_amount, 0) as total_amount
from {{ ref('stg_orders') }} o
left join payments p using (order_id)