require 'rails_helper'

resource 'Items' do
  explanation 'Items resource'

  let!(:user) { create(:user) }
  let!(:todo) { create(:todo, created_by: user.id) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }

  describe 'GET /v1/todos/:todo_id/items' do
    get '/v1/todos/:todo_id/items' do
      let(:params) { {} }
      let(:headers) { valid_headers }

      context 'When todo exists' do
        let(:todo_id) { todo.id }

        it 'Returns status code 200' do
          do_request

          expect(response_status).to eq(200)
        end

        it 'Returns all todo items' do
          do_request

          expect(json.size).to eq(20)
        end
      end

      context 'When todo does not exist' do
        let(:todo_id) { 0 }

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

  describe 'GET /v1/todos/:todo_id/items/:id' do
    get '/v1/todos/:todo_id/items/:id' do
      let(:todo_id) { todo.id }
      let(:params) { {} }
      let(:headers) { valid_headers }

      context 'When todo item exists' do
        let(:id) { items.first.id }

        it 'Returns status code 200' do
          do_request

          expect(response_status).to eq(200)
        end

        it 'Returns the item' do
          do_request

          expect(json['id']).to eq(id)
        end
      end

      context 'When todo item does not exist' do
        let(:id) { 0 }

        it 'Returns status code 404' do
          do_request

          expect(response_status).to eq(404)
        end

        it 'Returns a not found message' do
          do_request

          expect(response_body).to match(/Couldn't find Item/)
        end
      end
    end
  end

  describe 'POST /v1/todos/:todo_id/items' do
    post '/v1/todos/:todo_id/items' do
      let(:todo_id) { todo.id }
      let(:headers) { valid_headers }

      context 'When request attributes are valid' do
        let(:params) do
          FactoryBot.attributes_for(:item).except(:todo_id).to_json
        end

        it 'Create a new item in the db' do
          expect { do_request }.to change { Item.count }.by(1)
          expect(response_status).to eq(201)
        end
      end

      context 'When an invalid request' do
        let(:params) { {} }

        it 'Did\'nt create a new item in the db' do
          expect { do_request }.to change { Item.count }.by(0)
          expect(response_status).to eq(422)
        end

        it 'Returns a failure message' do
          do_request

          expect(response_body).to match(/Validation failed: Name can't be blank/)
        end
      end
    end
  end

  describe 'PUT /v1/todos/:todo_id/items/:id' do
    put '/v1/todos/:todo_id/items/:id' do
      let(:todo_id) { todo.id }
      let(:params) { { name: 'Mozart' }.to_json }
      let(:headers) { valid_headers }

      context 'When item exists' do
        let(:id) { items.first.id }

        it 'Returns status code 204' do
          do_request

          expect(response_status).to eq(204)
        end

        it 'Updates the item' do
          do_request

          updated_item = Item.find(id)
          expect(updated_item.name).to match(/Mozart/)
        end
      end

      context 'When the item does not exist' do
        let(:id) { 0 }

        it 'Returns status code 404' do
          do_request

          expect(response_status).to eq(404)
        end

        it 'Returns a not found message' do
          do_request

          expect(response_body).to match(/Couldn't find Item/)
        end
      end
    end
  end

  describe 'DELETE /v1/todos/:id' do
    delete '/v1/todos/:todo_id/items/:id' do
      let(:id) { items.first.id }
      let(:todo_id) { todo.id }
      let(:params) { {} }
      let(:headers) { valid_headers }

      it 'Delete item from db' do
        expect { do_request }.to change { Item.count }.by(-1)
        expect(response_status).to eq(204)
      end
    end
  end
end
