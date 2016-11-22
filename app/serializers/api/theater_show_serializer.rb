# Serializer for movie center shows
class Api::TheaterShowSerializer < Api::BaseSerializer
  attributes(
	:session_id,
	:place,
	:date,
	:price_cents,
	:max_price_cents,
	:min_price_cents,
	:hour,
	:minutes,
	:time_to_display,
	:long,
	:lat
  )
end
