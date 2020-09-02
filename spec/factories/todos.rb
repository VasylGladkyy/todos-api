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
FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 10) }
  end
end
