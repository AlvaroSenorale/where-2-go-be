class MovieEntity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :duration, type: Integer
  field :synopsis, type: String
  field :trailer_url, type: String
  field :genre, type: String
  field :poster_url, type: String
  field :people, type: Array
  field :directors, type: Array
  field :rating_description, type: String
  field :rating, type: String
  field :entity_type, type: Integer # 0 = film, 1 = theater

  has_many :cinema_shows # only if film

  has_many :shows # inly if theater
end
