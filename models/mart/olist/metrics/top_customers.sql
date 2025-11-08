with spend as (
  select customer_id, sum(coalesce(total_paid,0)) as total_spend
  from {{ ref('fact_olist_orders') }}
  group by 1
)
select
  s.customer_id,
  c.customer_unique_id,
  c.customer_city,
  c.customer_state,
  s.total_spend
from spend s
left join {{ ref('dim_olist_customer') }} c using (customer_id)
order by total_spend desc
limit 50