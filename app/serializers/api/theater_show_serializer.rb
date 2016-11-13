# Serializer for movie center shows
class Api::TheaterShowSerializer < Api::BaseSerializer
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
	:max_price_cents,
	:min_price_cents
  )
end
