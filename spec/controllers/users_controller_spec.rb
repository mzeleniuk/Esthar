require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }

  describe 'GET #show' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'responds successfully with an HTTP 200 status code' do
        get :show, id: user.id, format: :json

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is not authenticated' do
      it 'responds successfully with an HTTP 200 status code' do
        get :show, id: user.id, format: :json

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid user params' do
        it 'responds successfully with JSON format' do
          patch :update, id: user.id, user: {first_name: 'Josh'}, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'updates a User' do
          patch :update, id: user.id, user: {first_name: 'Josh'}, format: :json

          user.reload

          expect(user.first_name).to eq('Josh')
        end
      end

      context 'with invalid user params' do
        it 'responds successfully with JSON format' do
          patch :update, id: user.id, user: {username: nil}, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'does not updates a User' do
          patch :update, id: user.id, user: {username: nil}, format: :json

          user.reload

          expect(user.username).to_not be(nil)
        end
      end

      context 'with wrong user ID' do
        let(:other_user) { create :user }

        it 'responds successfully with JSON format' do
          patch :update, id: other_user.id, user: {first_name: 'Josh'}, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'does not updates a User' do
          patch :update, id: other_user.id, user: {first_name: 'Josh'}, format: :json

          other_user.reload

          expect(other_user.first_name).to_not eq('Josh')
        end
      end
    end

    context 'when user is not authenticated' do
      context 'with valid user params' do
        it 'does not responds successfully with JSON format' do
          patch :update, id: user.id, user: {first_name: 'Josh'}, format: :json

          expect(response.content_type).to eq(nil)
        end

        it 'does not updates a User' do
          patch :update, id: user.id, user: {first_name: 'Josh'}, format: :json

          user.reload

          expect(response).to have_http_status(401)
          expect(user.first_name).to_not eq('Josh')
        end
      end

      context 'with invalid user params' do
        it 'does not responds successfully with JSON format' do
          patch :update, id: user.id, user: {username: nil}, format: :json

          expect(response.content_type).to eq(nil)
        end

        it 'does not updates a User' do
          patch :update, id: user.id, user: {username: nil}, format: :json

          user.reload

          expect(response).to have_http_status(401)
          expect(user.username).to_not be(nil)
        end
      end

      context 'with wrong user ID' do
        let(:other_user) { create :user }

        it 'does not responds successfully with JSON format' do
          patch :update, id: other_user.id, user: {first_name: 'Josh'}, format: :json

          expect(response.content_type).to eq(nil)
        end

        it 'does not updates a User' do
          patch :update, id: other_user.id, user: {first_name: 'Josh'}, format: :json

          other_user.reload

          expect(response).to have_http_status(401)
          expect(other_user.first_name).to_not eq('Josh')
        end
      end
    end
  end
end
