require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index, format: :json

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    it 'responds successfully with JSON format' do
      post :create, post: {title: 'Test Post'}, format: :json

      expect(response.content_type).to eq('application/json')
    end

    it 'creates a new Post' do
      post :create, post: {title: 'Test Post'}, format: :json

      expect(Post.count).to eq(1)
    end
  end

  describe 'GET #show' do
    let(:post) { create :post }

    it 'responds successfully with an HTTP 200 status code' do
      get :show, id: post.id, format: :json

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT #upvote' do
    let(:post) { create :post, upvotes: 0 }

    it 'responds successfully with JSON format' do
      put :upvote, id: post.id, format: :json

      expect(response.content_type).to eq('application/json')
    end

    it 'increases upvotes count' do
      put :upvote, id: post.id, format: :json

      post.reload

      expect(post.upvotes).to eq(1)
    end
  end
end
