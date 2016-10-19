# require 'net/http'
class ImportMovieTheaterDataJob
  include MovieHelper

  def process
    process_entity(MOVIE_THEATER_ENPOINT, 1)
    process_theater_shows
  end

  private

  def process_theater_shows
    data = get_shows_data(THEATER_SHOWS_ENPOINT)
    store_shows(data['alternateContentCinemaShows'], 'theater')
  end

  def load_theater_shows(theater_show_data)
    play = MovieEntity.find(theater_show_data['contentId'])
    theater_show_data['dateShows'].each do |item|
      create_theater_shows(play, item)
    end
  end

  def create_theater_shows(play, item)
    item['shows'].each do |show_data|
      play.shows.push(create_theater_show(show_data))
    end
  end

  def create_theater_show(show_data)
    show = create_show(show_data)
    show.update_attributes(min_price_cents: price(show_data)[:min], max_price_cents: price(show_data)[:max])
    show.update_attributes(cinema_id: show_data['cinemaId'])
    show
  end

  def price(show_data)
    uri = URI(MOVIE_PRICES_ENDPOINT)
    uri.query = URI.encode_www_form({ cinemaId: show_data['cinemaId'], showId: show_data['sessionId'] })
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    if data.last
      { max: data.last['normalTicketTypePriceInCents'],
        min: data.last['unitPrice'] }
    else
      {}
    end
  end
end

