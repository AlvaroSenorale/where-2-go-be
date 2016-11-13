# Base serializer
class Api::BaseSerializer < ActiveModel::Serializer
  # In order to remove empty fields before rendering
  def attributes
    super.compact
  end

  def id
    object.id.to_s
  end
end