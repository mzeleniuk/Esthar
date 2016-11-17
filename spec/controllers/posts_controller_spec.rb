require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }

  describe 'GET #index' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'responds successfully with an HTTP 200 status code' do
        get :index, format: :json

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is not authenticated' do
      it 'responds successfully with an HTTP 200 status code' do
        get :index, format: :json

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid post params' do
        it 'responds successfully with JSON format' do
          post :create, post: {title: 'Test Post'}, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'creates a new Post' do
          post :create, post: {title: 'Test Post'}, format: :json

          expect(Post.count).to eq(1)
        end
      end

      context 'with invalid post params' do
        it 'responds successfully with JSON format' do
          post :create, post: {title: nil}, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'does not creates a new Post' do
          post :create, post: {title: nil}, format: :json

          expect(Post.count).to eq(0)
        end
      end
    end

    context 'when user is not authenticated' do
      context 'with valid post params' do
        it 'does not responds successfully with JSON format' do
          post :create, post: {title: 'Test Post'}, format: :json

          expect(response.content_type).to eq(nil)
        end

        it 'does not creates a new Post' do
          post :create, post: {title: 'Test Post'}, format: :json

          expect(Post.count).to eq(0)
          expect(response).to have_http_status(401)
        end
      end

      context 'with invalid post params' do
        it 'does not responds successfully with JSON format' do
          post :create, post: {title: nil}, format: :json

          expect(response.content_type).to eq(nil)
        end

        it 'does not creates a new Post' do
          post :create, post: {title: nil}, format: :json

          expect(Post.count).to eq(0)
          expect(response).to have_http_status(401)
        end
      end
    end
  end

  describe 'GET #show' do
    let(:post) { create :post }

    context 'when user is authenticated' do
      before { sign_in user }

      it 'responds successfully with an HTTP 200 status code' do
        get :show, id: post.id, format: :json

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is not authenticated' do
      it 'responds successfully with an HTTP 200 status code' do
        get :show, id: post.id, format: :json

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT #upvote' do
    let(:post) { create :post, upvotes: 0 }

    context 'when user is authenticated' do
      before { sign_in user }

      context 'and user is not voted yet' do
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

      context 'and user is already voted' do
        let!(:vote) { create :vote, user: user, post_id: post.id }

        it 'responds successfully with JSON format' do
          put :upvote, id: post.id, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'does not increases upvotes count' do
          put :upvote, id: post.id, format: :json

          expect(response).to have_http_status(422)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'does not responds successfully with JSON format' do
        put :upvote, id: post.id, format: :json

        expect(response.content_type).to eq(nil)
      end

      it 'does not increases upvotes count' do
        put :upvote, id: post.id, format: :json

        post.reload

        expect(post.upvotes).to eq(0)
        expect(response).to have_http_status(401)
      end
    end
  end
end
