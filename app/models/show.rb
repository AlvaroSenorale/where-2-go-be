class Show
  include Mongoid::Document
  include Mongoid::Timestamps

  field :session_id, type: String
  field :place, type: String
  field :date, type: Date # to filter año-mes-dia
  field :date_to_display, type: String
  field :time_to_display, type: String

  field :format, type: Integer # 2 = 2D , 3 = 3D
  field :format_lang, type: String
  field :translation, type: Integer # 2 = Español, # 3 = Sub
  field :screen_name, type: String # Sala
  field :screen_number, type: Integer
  
  field :price_cents, type: Integer # if film cinema show

  field :max_price_cents, type: Integer # if theater show
  field :min_price_cents, type: Integer # if theater show
  
  #tickantel
  field :hour, type: Integer
  field :minutes, type: Integer

  field :long, type: Float
  field :lat, type: Float
  
  belongs_to :movie_entity # if theater show
  belongs_to :tick_antel_entity

  belongs_to :cinema_shows # if film cinema show

  belongs_to :cinema # if theater show

  before_save :update_movies_location

  before_save :parse_time

  before_save :parse_date
  
  private

  def parse_date
    return true unless date
    self.date_to_display = convert_days_to_spanish(date.to_time.strftime('%A, %b %d - %Y'))
  end

  def convert_days_to_spanish(date)
    DAYS_MAPPING.each do |m|
      date.gsub!(m[0],m[1])
    end
    date
  end

  def parse_time
    return true unless !time_to_display.blank? && !hour && !minutes
    data = time_to_display.match(/^([0-9]|0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])$/)
    return true unless data
    self.hour = data[1].to_i
    self.minutes = data[2].to_i
  end

  def update_movies_location
    if cinema
      self.long = cinema.long
      self.lat = cinema.lat
    elsif cinema_shows && cinema_shows.cinema 
      self.long = cinema_shows.cinema.long
      self.lat = cinema_shows.cinema.lat
    end
  end
end
