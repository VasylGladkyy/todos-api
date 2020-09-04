require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:todo) }
  end

  describe 'Validations' do
    context 'Presence validation' do
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'Length validation' do
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
    end
  end
end
