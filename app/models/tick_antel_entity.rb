class TickAntelEntity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  field :synopsis, type: String

  field :place, type: String
  field :poster_url, type: String

  field :entity_type, type: Integer # 1 = theater, 2 = music

  has_many :tick_antel_shows
end
