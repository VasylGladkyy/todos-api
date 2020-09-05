require 'rails_helper'

resource 'Todos' do
  explanation 'Todos resource'

  let!(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }

  describe 'GET /v1/todos' do
    get '/v1/todos' do
      let(:params) { {} }
      let(:headers) { valid_headers }

      it 'Returns todos' do
        do_request

        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'Returns status code 200' do
        do_request

        expect(response_status).to eq(200)
      end
    end
  end

  describe 'GET /v1/todos/:id' do
    get '/v1/todos/:id' do
      let(:params) { {} }
      let(:headers) { valid_headers }

      context 'When the record exists' do
        let(:id) { todos.first.id }

        it 'Returns the todo' do
          do_request

          expect(json).not_to be_empty
          expect(json['id']).to eq(id)
        end

        it 'Returns status code 200' do
          do_request

          expect(response_status).to eq(200)
        end
      end

      context 'When the record does not exist' do
        let(:id) { 100 }

        it 'Returns status code 404' do
          do_request

          expect(response_status).to eq(404)
        end

        it 'Returns a not found message' do
          do_request

          expect(response_body).to match(/Couldn't find Todo/)
        end
      end
    end
  end

  describe 'POST /v1/todos' do
    post '/v1/todos' do
      let(:headers) { valid_headers }

      context 'When the request is valid' do
        let(:params) do
          { title: 'Learn Elm', created_by: user.id.to_s }.to_json
        end

        it 'Creates a todo' do
          expect { do_request }.to change { Todo.count }.by(1)
          expect(json['title']).to eq('Learn Elm')
        end

        it 'Returns status code 201' do
          do_request

          expect(response_status).to eq(201)
        end
      end

      context 'When the request is invalid' do
        let(:params) { { title: nil }.to_json }

        it 'Returns status code 422' do
          do_request

          expect(response_status).to eq(422)
        end

        it 'Returns a validation failure message' do
          do_request

          expect(response_body)
            .to match(/Validation failed: Title can't be blank/)
        end
      end
    end
  end

  describe 'PUT /todos/:id' do
    put '/v1/todos/:id' do
      let(:id) { todos.first.id }
      let(:headers) { valid_headers }
      let(:params) { { title: 'Shopping' }.to_json }

      context 'When the record exists' do
        it 'Updates the record' do
          do_request

          expect(response_body).to be_empty
        end

        it 'Returns status code 204' do
          do_request

          expect(response_status).to eq(204)
        end
      end
    end
  end

  describe 'DELETE /todos/:id' do
    delete '/v1/todos/:id' do
      let(:id) { todos.first.id }
      let(:headers) { valid_headers }
      let(:params) { {} }

      it 'Delete todo from db' do
        expect { do_request }.to change { Todo.count }.by(-1)
        expect(response_status).to eq(204)
      end
    end
  end
end
