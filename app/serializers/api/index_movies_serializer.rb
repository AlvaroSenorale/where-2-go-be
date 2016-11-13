# Serializer for movie center shows
class Api::IndexMoviesSerializer < Api::BaseSerializer
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
    :entity_type,
  )
  
  has_many :shows, serializer: Api::MovieShowSerializer

  def shows
    object.cinema_shows.map do |cs|
      cs.shows
    end.flatten
  end
end
