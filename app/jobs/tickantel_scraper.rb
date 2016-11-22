class TickantelScraper
  def process
    process_theater
    process_music
  end

  private

  def process_music
    data = agent.get(TICKANTEL_MUSIC_URL)
    paths = data.search('.block-grid-item a')
    paths.each do |path|
      path_data = agent.get(TICKANTEL + path['href'])
      process_function(path_data, 2)
    end
  end

  def process_theater
    data = agent.get(TICKANTEL_THEATER_URL)
    paths = data.search('.block-grid-item a')
    paths.each do |path|
      path_data = agent.get( TICKANTEL + path['href'])
      process_function(path_data, 1)
    end
  end

  def agent
    @agent ||= Mechanize.new
  end

  def process_function(data, type)
    function = create_function(data, type)
    shows_data(data).each do |show|
      create_tick_antel_show(show, function)
    end
  end

  def create_function(data, type)
    print '.'
    title =  data.search('.info-box .title').text
    synop = data.search('.info-box').text
    banner = get_banner(data) 
    banner.slice!(0)
    banner.slice!(0)
    TickAntelEntity.create(title: title, synopsis: synop, poster_url: 'http://' + banner, entity_type: type)
  end

  def create_tick_antel_show(show, function)
    show_data = agent.click(show.search('.link').last)
    
    date = convert_date_to_english(show.search('.date').text)
    
    day = Time.zone.parse(date)
    hour = get_hour(show).to_i
    minutes = get_minutes(show).to_i
    time_to_display = get_hour(show) + ':' + get_minutes(show)
    
    min_price = show_prices(show).min
    max_price = show_prices(show).max

    place = get_place(show)
    coord = get_coord(place)
    
    Show.create(tick_antel_entity: function,
                         date: day,
                         hour: hour,
                         minutes: minutes,
                         time_to_display: time_to_display,
                         max_price_cents: max_price,
                         min_price_cents: min_price,
                         price_cents: max_price,
                         lat: coord[:lat],
                         long: coord[:long],
                         place: place)
  end

  def convert_date_to_english(date)
    MONTH_MAPPING.each do |m|
      date.gsub!(m[0],m[1])
    end
    date
  end

  def get_coord(place)
    case place
    when /Sala Verdi/
        VERDI_COORDS
    when /Teatro Solís/
        SOLIS_COORDS
    when /Teatro El Galpón/
        GALPON_COORDS
    when /Auditorio Nacional/
        AUDITORIO_NAC_COORDS
    when /Centro Cultural Florencio Sánchez/
        FLORENCIO_COORDS
    when /Sala Camacuá/
        CAMACUA_COORDS
    when /Sala Zitarrosa/
        ZITARROSA_COORDS
    when /Auditorio Nelly Goitiño/
        AUDITORIO_NELLY_COORDS
    when /Teatro Agadu/
        AGADU_COORDS
    when /Bluzz Live/
        BLUZZ_COORDS
    when /Velódromo Municipal/
        VELODROMO_COORDS
    when /Centro Social Tala/
        TALA_COORDS
    when /Museo del Carnaval/
        CARNAVAL_COORDS

    when /Teatro del Anglo/
        ANGLO_COORDS
    when /Teatro Municipal Lavalleja/
        LAVALLEJA_COORDS
    else
      {}
    end
  end

  def show_prices(show)
    price_array = show.parent.search('.text-right').map(&:text).select do |price|
      price.include?('$')
    end

    price_array.map do |price|
      price[1..-1].to_i
    end
  end

  def get_hour(panel)
    panel.search('.place span')[0].text.split(':')[0]
  end

  def get_minutes(panel)
    panel.search('.place span')[0].text.split(':')[1].split('h').last
  end

  def shows_data(data)
    data.search('.list-agenda .panel-heading')
  end

  def get_place(panel)
    panel.search('.place span')[2..-1].map(&:text).join(' - ') if panel
  end

  def get_banner(data)
    data.search('#imagenContainer .item img').attr('src').value
  end
end

