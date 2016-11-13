# Serializer for movie center shows
class Api::IndexAntelSerializer < Api::BaseSerializer
  attributes(
    :title,
    :synopsis,
    :place,
    :poster_url
  )
  
  has_many :tick_antel_shows, serializer: Api::TickAntelShowSerializer
end
