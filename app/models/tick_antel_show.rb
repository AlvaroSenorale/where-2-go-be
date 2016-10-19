class TickAntelShow
  include Mongoid::Document
  include Mongoid::Timestamps

  field :day, type: Date

  field :hour, type: Integer
  field :minutes, type: Integer

  field :max_price, type: String
  field :min_price, type: String

  belongs_to :tick_antel_entity
end
