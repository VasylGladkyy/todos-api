# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  name       :string
#  done       :boolean
#  todo_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Item < ApplicationRecord
  belongs_to :todo

  validates :name, presence: true, length: { maximum: 50 }
end
