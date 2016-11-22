# require 'net/http'
class ImportMovieCinemaDataJob
  include MovieHelper

  def process
    create_default_cinemas
    process_entity(MOVIE_FILMS_ENPOINT, 0)
    process_cinema_shows
  end

  private

  def process_cinema_shows
    data = get_shows_data(CINEMA_SHOWS_ENPOINT)
    store_shows(data['contentCinemaShows'], 'cinema')
  end

  def load_cinema_shows(cinema_show_data)
    film = MovieEntity.find(cinema_show_data['contentId'])
    cinema_show_data['cinemaShows'].each do |item|
      create_cinema_shows(film, item)
    end
  end

  def create_cinema_shows(film, item)
    cinema = Cinema.find(item['cinema']['externalId'])
    cinema_show = CinemaShow.create(movie_entity: film, cinema: cinema)
    item['shows'].each do |show_data|
      cinema_show.shows.push(create_cinema_show(show_data))
    end
  end

  def create_cinema_show(show_data)
    show = create_show(show_data)
    show.update_attributes(price_cents: get_film_price(show_data['cinemaId'], show_data['sessionId']))
    show
  end

  def get_film_price(cinema_id, show_id)
    uri = URI(MOVIE_PRICES_ENDPOINT)
    uri.query = URI.encode_www_form({ cinemaId: cinema_id, showId: show_id })
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    unless data.is_a?(Array)
      binding.pry
    end
    data.last['normalTicketTypePriceInCents']
  end
end

