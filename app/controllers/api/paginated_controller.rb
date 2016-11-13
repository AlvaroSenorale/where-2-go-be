# Not used
class Api::PaginatedController < Api::BaseController
  def index
    render_collection
  end

  private

  def render_collection
    render json: paginate_collection(collection), each_serializer: index_resource_serializer,
           meta: { total_pages: total_pages(collection) }
  end

  def paginate_collection(collection)
    @paginated_collection ||= collection.paginate(page: params[:page], per_page: DEFAULT_API_PER_PAGES)
  end

  def total_pages(collection)
    paginate_collection(collection).total_pages
  end

  def resource_serializer
    fail 'resource_serializer should be implemented in the subclass'
  end

  def collection
    fail 'collection should be implemented in the subclass'
  end
end