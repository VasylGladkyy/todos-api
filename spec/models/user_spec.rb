require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:todos) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }
  end
end