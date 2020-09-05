require 'rails_helper'

resource 'Users' do
  explanation 'Users sign in'
  describe 'POST /v1/signup' do
    let(:user) { build(:user) }

    post '/v1/signup' do
      context 'When valid request' do
        let(:params) do
          FactoryBot.attributes_for(:user, password_confirmation: user.password).to_json
        end
        let(:headers) { valid_headers.except('Authorization') }

        it 'Creates a new user' do
          expect { do_request }.to change { User.count }.by(1)
          expect(response_status).to eq(201)
        end

        it 'Returns success message' do
          do_request

          expect(json['message']).to match(/Account created successfully/)
        end

        it 'Returns an authentication token' do
          do_request

          expect(json['auth_token']).not_to be_nil
        end
      end

      context 'When invalid request' do
        let(:params) { {} }
        let(:headers) { valid_headers.except('Authorization') }

        it 'Does not create a new user' do
          do_request

          expect(response_status).to eq(422)
        end

        it 'Returns failure message' do
          do_request

          expect(json['message'])
            .to eq(
              "Validation failed: Password can't be blank, "\
              "Name can't be blank, Email can't be blank, "\
              'Email is not valid email'
            )
        end
      end
    end
  end
end
