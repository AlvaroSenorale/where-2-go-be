class Api::TickAntelShowSerializer < Api::BaseSerializer
  attributes(
    :day,
    :hour,
    :minutes,
    :max_price,
    :min_price
  )
end