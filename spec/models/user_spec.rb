require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Secure password' do
    it { is_expected.to have_secure_password }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:todos) }
  end

  describe 'Validations' do
    context 'Presence validation' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'Length validation' do
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
    end

    context 'Email validation reject invalid addresses' do
      let(:user) { build(:user) }
      it 'not valid with invalid addresses' do
        invalid_addresses = %w[users@example,com user_at_foo.org users.name@example
                               .foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).not_to be_valid
        end
      end
    end
  end
end
