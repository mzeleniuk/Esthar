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
end
