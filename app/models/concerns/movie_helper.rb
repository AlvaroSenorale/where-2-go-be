module MovieHelper
  extend ActiveSupport::Concern
  included do

    def process_entity(url, type)
      uri = URI(url)
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)
      store_entities(data['items'], type)
    end
    
    def create_default_cinemas
      Cinema.create(cinema_name: 'Movie Montevideo', _id: '001')
      Cinema.create(cinema_name: 'Movie Portones', _id: '002')
      Cinema.create(cinema_name: 'Movie Punta Carretas', _id: '003')
      Cinema.create(cinema_name: 'Movie Nuevocentro', _id: '005')
    end

    def store_entities(items, type)
      items.each  do |item|
        load_entity(item, type)
      end
    end

    def load_entity(item, type)
      MovieEntity.create(_id: item['content']['id'],
                  title: item['content']['title'],
                  duration: item['content']['duration'],
                  synopsis: item['content']['synopsis'],
                  trailer_url: item['content']['trailerUrl'],
                  genre: item['content']['genre'],
                  poster_url: item['content']['posterUrl'],
                  rating_description: item['content']['ratingDescription'],
                  rating: item['content']['rating'],
                  people: item['content']['people'],
                  directors: item['content']['director'],
                  entity_type: type
                  )
    end

    def get_shows_data(url)
      uri = URI(url)
      uri.query = URI.encode_www_form({ begin: Time.zone.today.to_s })
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end

    def store_shows(items, show_type)
      items.each  do |item|
        send("load_#{show_type}_shows".to_sym, item)
      end
    end

    def create_show(show_data)
      print '.'
      Show.create(_id: show_data['id'],
                  session_id: show_data['sessionId'],
                  cinema_name: show_data['cinemaName'],
                  date: show_data['date'],
                  date_to_display: show_data['dateToDisplay'],
                  time_to_display: show_data['timeToDisplay'],
                  format: show_data['format'],
                  format_lang: show_data['formatLang'],
                  translation: show_data['translation'],
                  screen_name: show_data['screenName'],
                  screen_number: show_data['screenNumber'])
    end 
  end
end
