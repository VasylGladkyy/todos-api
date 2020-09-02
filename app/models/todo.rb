# == Schema Information
#
# Table name: todos
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_by :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Todo < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :title, presence: true
  validates :created_by, presence: true
end
