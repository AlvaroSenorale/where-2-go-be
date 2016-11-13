class Api::TheaterController < Api::BaseController
  def index
    render_collection
  end

  private

  def render_collection
    render json: theater_collection_json, serializer: index_resource_serializer, root: false
  end

  def index_resource_serializer
    Api::IndexTheaterSerializer
  end

  def collection
    @collection ||= TickAntelEntity.where(entity_type: 1).all
  end

  def movie_collection
    @movie_collection ||= MovieEntity.where(entity_type: 1).all
  end

  def theater_collection_json
    {antel: collection, movie_center: movie_collection}
  end
end
