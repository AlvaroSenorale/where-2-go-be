class Api::MoviesController < Api::BaseController
  def index
    render_collection
  end

  private

  def render_collection
    render json: collection, each_serializer: index_resource_serializer, root: false
  end

  def index_resource_serializer
    Api::IndexMoviesSerializer
  end

  def collection
    @collection ||= MovieEntity.where(entity_type: 0).all
  end
end
