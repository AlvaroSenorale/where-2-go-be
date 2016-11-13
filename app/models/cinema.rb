class Cinema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :cinema_name, type: String
  field :long, type: Float
  field :lat, type: Float
  
  has_many :cinema_shows
  has_many :shows # theater
end
