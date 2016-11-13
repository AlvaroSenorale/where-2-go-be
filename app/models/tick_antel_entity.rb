class TickAntelEntity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String

  field :synopsis, type: String

  field :poster_url, type: String

  field :entity_type, type: Integer # 1 = theater, 2 = music

  has_many :tick_antel_shows

  scope :filtered, ->(q, type) { where(:id.in => filtered_tickantel_entities_ids(q) , entity_type: type)}

  private

  def self.filtered_tickantel_entities_ids(query)
  	TickAntelShow.where(extra_selector(query)).pluck(:tick_antel_entity_id)
  end

  def self.extra_selector(query)
    return {} unless query

    RansackMongo::Query.parse(query)
  end
end
