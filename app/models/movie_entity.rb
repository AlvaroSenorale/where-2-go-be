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

  scope :film_filtered, ->(q) { where(:id.in => films_filtered_moviecenter_entities_ids(q) , entity_type: 0) }

  scope :theater_filtered, ->(q) { where(:id.in => theater_filtered_moviecenter_entities_ids(q) , entity_type: 1) }

  private

  def self.films_filtered_moviecenter_entities_ids(query)
    CinemaShow.where(:id.in => filtered_cinema_shows_id(query)).pluck(:movie_entity_id)
  end

  def self.filtered_cinema_shows_id(query)
    Show.where(extra_selector(query)).pluck(:cinema_shows_id)
  end

  def self.theater_filtered_moviecenter_entities_ids(query)
    Show.where(extra_selector(query)).pluck(:movie_entity_id)
  end

  def self.extra_selector(query)
    return {} unless query

    RansackMongo::Query.parse(query)
  end
end
