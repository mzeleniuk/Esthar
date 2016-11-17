require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }
  let(:new_post) { create :post }

  describe 'POST #create' do
    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid comment params' do
        it 'responds successfully with JSON format' do
          post :create, post_id: new_post.id, comment: {body: 'Test Comment'}, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'creates a new Comment' do
          post :create, post_id: new_post.id, comment: {body: 'Test Comment'}, format: :json

          expect(Comment.count).to eq(1)
        end
      end

      context 'with invalid comment params' do
        it 'responds successfully with JSON format' do
          post :create, post_id: new_post.id, comment: {body: nil}, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'does not creates a new Comment' do
          post :create, post_id: new_post.id, comment: {body: nil}, format: :json

          expect(Comment.count).to eq(0)
        end
      end
    end

    context 'when user is not authenticated' do
      context 'with valid comment params' do
        it 'does not responds successfully with JSON format' do
          post :create, post_id: new_post.id, comment: {body: 'Test Comment'}, format: :json

          expect(response.content_type).to eq(nil)
        end

        it 'does not creates a new Comment' do
          post :create, post_id: new_post.id, comment: {body: 'Test Comment'}, format: :json

          expect(Comment.count).to eq(0)
          expect(response).to have_http_status(401)
        end
      end

      context 'with invalid comment params' do
        it 'does not responds successfully with JSON format' do
          post :create, post_id: new_post.id, comment: {body: nil}, format: :json

          expect(response.content_type).to eq(nil)
        end

        it 'does not creates a new Comment' do
          post :create, post_id: new_post.id, comment: {body: nil}, format: :json

          expect(Comment.count).to eq(0)
          expect(response).to have_http_status(401)
        end
      end
    end
  end

  describe 'GET #show' do
    let(:comment) { create :comment, post_id: new_post.id }

    context 'when user is authenticated' do
      before { sign_in user }

      it 'responds successfully with an HTTP 200 status code' do
        get :show, post_id: new_post.id, id: comment.id, format: :json

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is not authenticated' do
      it 'responds successfully with an HTTP 200 status code' do
        get :show, post_id: new_post.id, id: comment.id, format: :json

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT #upvote' do
    let(:comment) { create :comment, post_id: new_post.id }

    context 'when user is authenticated' do
      before { sign_in user }

      context 'and user is not voted yet' do
        it 'responds successfully with JSON format' do
          put :upvote, post_id: new_post.id, id: comment.id, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'increases upvotes count' do
          put :upvote, post_id: new_post.id, id: comment.id, format: :json

          comment.reload

          expect(comment.upvotes).to eq(1)
        end
      end

      context 'and user is already voted' do
        let!(:vote) { create :vote, user: user, comment: comment }

        it 'responds successfully with JSON format' do
          put :upvote, post_id: new_post.id, id: comment.id, format: :json

          expect(response.content_type).to eq('application/json')
        end

        it 'does not increases upvotes count' do
          put :upvote, post_id: new_post.id, id: comment.id, format: :json

          expect(response).to have_http_status(422)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'does not responds successfully with JSON format' do
        put :upvote, post_id: new_post.id, id: comment.id, format: :json

        expect(response.content_type).to eq(nil)
      end

      it 'does not increases upvotes count' do
        put :upvote, post_id: new_post.id, id: comment.id, format: :json

        comment.reload

        expect(comment.upvotes).to eq(0)
        expect(response).to have_http_status(401)
      end
    end
  end
end
