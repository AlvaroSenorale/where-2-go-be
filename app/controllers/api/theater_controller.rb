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

  def theater_collection_json
    { antel: collection, movie_center: movie_collection }
  end

  def collection
    @collection ||= TickAntelEntity.filtered(antel_query, 1).includes(:tick_antel_shows, with: filtered_antel_shows)
  end

  def movie_collection
    @movie_collection ||= MovieEntity.theater_filtered(movie_query)
                               .includes(:shows, with: filtered_theater_shows)
  end

  def filtered_antel_shows
    ->(as) { as.where(antel_ransack_query) }
  end

  def antel_query
    params[:antel_q]
  end

  def antel_ransack_query
    return {} unless antel_query

    RansackMongo::Query.parse(antel_query)
  end

  def filtered_theater_shows
    ->(s) { s.where(movie_ransack_query) }
  end

  def movie_query
    params[:movie_q]
  end

  def movie_ransack_query
    return {} unless movie_query

    RansackMongo::Query.parse(movie_query)
  end
end
