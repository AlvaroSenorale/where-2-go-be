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
      path_data = agent.get(  TICKANTEL + path['href'])
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
    place = get_place(shows_data(data).last)
    TickAntelEntity.create(title: title, synopsis: synop, poster_url: banner, place: place, entity_type: type)
  end

  def create_tick_antel_show(show, function)
    show_data = agent.click(show.search('.link').last)
    
    date = show_data.search('.date').text
    day = Time.zone.parse(date)
    hour = get_hour(show_data).to_i
    minutes = get_minutes(show_data).to_i
    
    min_price = show_prices(show_data).min
    max_price = show_prices(show_data).max

    TickAntelShow.create(tick_antel_entity: function,
                         day: day,
                         hour: hour,
                         minutes: minutes,
                         max_price: max_price,
                         min_price: min_price)
  end

  def show_prices(panel)
    price_array = panel.search('.text-right').map(&:text).select do |price|
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

