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
    @collection ||= TickAntelEntity.filtered(query, 2).includes(:tick_antel_shows, with: filtered_antel_shows)
  end

  def filtered_antel_shows
    ->(as) { as.where(ransack_query) }
  end

  def query
    params[:q]
  end

  def ransack_query
    return {} unless query

    RansackMongo::Query.parse(query)
  end
end
