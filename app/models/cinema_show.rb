class CinemaShow
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :shows
  
  belongs_to :movie_entity
  belongs_to :cinema
end
