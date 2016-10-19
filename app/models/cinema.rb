class Cinema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :cinema_name, type: String
  
  has_many :cinema_shows
  has_many :shows # theater
end
