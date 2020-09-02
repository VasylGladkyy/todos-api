require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:items) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:created_by) }
  end
end
