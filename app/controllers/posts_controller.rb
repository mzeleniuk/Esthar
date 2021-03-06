class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :upvote]

  def index
    respond_with Post.all
  end

  def create
    respond_with Post.create(post_params.merge(user_id: current_user.id))
  end

  def show
    respond_with Post.find(params[:id])
  end

  def upvote
    post = Post.find(params[:id])

    if post.votes.create(user_id: current_user.id).save
      post.increment!(:upvotes)
    else
      return render json: {error: 'Post is already voted'}, status: 422
    end

    respond_with post
  end

  private

  def post_params
    params.require(:post).permit(:link, :title, :body)
  end
end
