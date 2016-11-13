class Api::IndexTheaterMovieSerializer < Api::BaseSerializer
  attributes(
    :title,
    :duration,
    :synopsis,
    :trailer_url,
    :genre,
    :poster_url,
    :people,
    :directors,
    :rating_description,
    :rating,
    :entity_type
  )
  
  has_many :shows, serializer: Api::TheaterShowSerializer
end
