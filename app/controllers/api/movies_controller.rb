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
    @collection ||= MovieEntity.film_filtered(query)
                               .includes(:cinema_shows, with: filtered_cinema_shows)
  end

  def filtered_cinema_shows
    ->(cs) { cs.includes(:shows, with: filtered_shows) }
  end

  def filtered_shows
    ->(s) { s.where(ransack_query) }
  end

  def query
    params[:q]
  end

  def ransack_query
    return {} unless query

    RansackMongo::Query.parse(query)
  end
end
