class Api::TickAntelShowSerializer < Api::BaseSerializer
  attributes(
    :date_to_display,
    :time_to_display,
    :hour,
    :minutes,
    :max_price_cents,
    :min_price_cents,
    :price_cents,
    :place,
    :lat,
    :longitud
  )

  def longitud
    object.long
  end
end