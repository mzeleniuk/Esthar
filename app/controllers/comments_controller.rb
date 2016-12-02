class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :upvote]

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.create(comment_params.merge(user_id: current_user.id))

    respond_with post, comment
  end

  def show
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])

    respond_with post, comment
  end

  def upvote
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])

    if comment.votes.create(user_id: current_user.id).save
      comment.increment!(:upvotes)
    else
      return render json: {error: 'Comment is already voted'}, status: 422
    end

    respond_with post, comment
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
