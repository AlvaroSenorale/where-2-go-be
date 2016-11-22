class Api::TickAntelShowSerializer < Api::BaseSerializer
  attributes(
    :date,
    :hour,
    :minutes,
    :max_price_cents,
    :min_price_cents,
    :price_cents,
    :place,
    :lat,
    :long
  )
end