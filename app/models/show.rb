class Show
  include Mongoid::Document
  include Mongoid::Timestamps

  field :session_id, type: String
  field :cinema_name, type: String
  field :date, type: Date
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
  
  belongs_to :cinema_shows # if film cinema show

  belongs_to :movie_entity # if theater show
  belongs_to :cinema # if theater show
end
