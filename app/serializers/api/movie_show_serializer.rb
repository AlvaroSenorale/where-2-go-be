# Serializer for movie center shows
class Api::MovieShowSerializer < Api::BaseSerializer
  attributes(
    :session_id,
    :place,
    :date,
    :date_to_display,
    :time_to_display,
    :format,
    :format_lang,
    :translation,
    :screen_name,
    :screen_number,
    :price_cents,
    :lat,
    :long
  )

  def lat
    object.cinema_shows.cinema.lat
  end

  def long
    object.cinema_shows.cinema.long
  end
end
