class Api::MusicController < Api::BaseController
  def index
    render_collection
  end

  private

  def render_collection
    render json: collection, each_serializer: index_resource_serializer, root: false
  end

  def index_resource_serializer
    Api::IndexAntelSerializer
  end

  def collection
    @collection ||= TickAntelEntity.where(entity_type: 2).all
  end
end
