require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'GET #angular' do
    it 'responds successfully with an HTTP 200 status code' do
      get :angular

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the application template' do
      get :angular

      expect(response).to render_template('layouts/application')
    end
  end
end
