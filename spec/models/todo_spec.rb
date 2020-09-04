require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:items) }
  end

  describe 'Validations' do
    context 'Presence validation' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:created_by) }
    end

    context 'Length validation' do
      it { is_expected.to validate_length_of(:title).is_at_most(255) }
    end
  end
end
