# Serializer for movie center shows
class Api::IndexTheaterSerializer < Api::BaseSerializer
  attributes(
    :tick_antel,
    :movie_center
  )

  def tick_antel
  	collection_serializer(object[:antel], Api::IndexAntelSerializer) 
  end

  def movie_center
  	collection_serializer(object[:movie_center], Api::IndexTheaterMovieSerializer) 
  end

  def collection_serializer(obj, serializer)
    ActiveModel::ArraySerializer.new(obj, each_serializer: serializer)
  end
end