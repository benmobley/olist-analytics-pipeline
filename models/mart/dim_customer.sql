select
  c.customer_id,
  c.first_name,
  c.last_name,
  c.email
from {{ ref('stg_customers') }} c