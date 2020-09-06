module V1
  class ItemSerializer < ActiveModel::Serializer
    attributes :id, :name, :done
  end
end
