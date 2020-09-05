require 'rails_helper'

resource 'Authentication' do
  explanation 'Authentication resource'
  describe 'POST /v1/auth/login' do
    let!(:user) { create(:user) }

    post '/v1/auth/login' do
      context 'When request is valid' do
        let(:params) do
          {
            email: user.email,
            password: user.password
          }.to_json
        end
        let(:headers) { valid_headers.except('Authorization') }

        it 'Returns an authentication token' do
          do_request

          expect(json['auth_token']).not_to be_nil
        end
      end

      context 'When request is invalid' do
        let(:params) do
          {
            email: Faker::Internet.email,
            password: Faker::Internet.password
          }.to_json
        end
        let(:headers) { valid_headers.except('Authorization') }

        it 'Returns a failure message' do
          do_request

          expect(json['message']).to match(/Invalid credentials/)
        end
      end
    end
  end
end
