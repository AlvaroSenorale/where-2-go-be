# Serializer for movie center shows
class Api::MovieShowSerializer < Api::BaseSerializer
  attributes(
    :session_id,
    :cinema_name,
    :date,
    :date_to_display,
    :time_to_display,
    :format,
    :format_lang,
    :translation,
    :screen_name,
    :screen_number,
    :price_cents
  )
end
