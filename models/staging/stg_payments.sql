select
  id as payment_id,
  order_id,
  payment_method,
  cast(amount as numeric) as amount
from {{ ref('payments') }}