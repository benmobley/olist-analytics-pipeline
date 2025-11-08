select
  date_trunc('month', order_purchase_ts)::date as month,
  sum(coalesce(total_paid,0)) as revenue
from {{ ref('fact_olist_orders') }}
where order_status not in ('canceled','unavailable')
group by 1
order by 1