# Serializer for movie center shows
class Api::IndexAntelSerializer < Api::BaseSerializer
  attributes(
    :title,
    :synopsis,
    :poster_url
  )
  
  has_many :shows, serializer: Api::TickAntelShowSerializer
end
