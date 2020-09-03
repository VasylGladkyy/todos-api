# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  has_many :todos, foreign_key: :created_by, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
end
