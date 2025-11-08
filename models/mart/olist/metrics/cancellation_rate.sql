with by_month as (
  select
    date_trunc('month', order_purchase_ts)::date as month,
    count(*)::numeric as total_orders,
    count(*) filter (where order_status in ('canceled','unavailable'))::numeric as canceled_orders
  from {{ ref('fact_olist_orders') }}
  group by 1
)
select
  month, total_orders, canceled_orders,
  case when total_orders=0 then 0 else canceled_orders/total_orders end as cancellation_rate
from by_month
order by month