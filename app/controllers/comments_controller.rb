class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.user_id = current_user.id
    @vote = Vote.new

    if @comment.save
     redirect_to @post, notice: "Comment created!"
    else
      redirect_to @post, flash: { error: "Can't add empty comment!" } 
    end
  end

  def mark_as_not_abusive    
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.abusive = false
    if @comment.save
      redirect_to post_path(@post)
    end
  end

  def vote_up
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    if current_user.voted? comment
      redirect_to post, flash: { error: "Can't vote again!" }
    else
      Vote.create(user_id: current_user.id, comment_id: comment.id, value: 1)
      redirect_to post, notice: "Vote added!"
    end
  end

  def vote_down
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    if current_user.voted? comment
      redirect_to post, flash: { error: "Can't vote again!" }
    else
      Vote.create(user_id: current_user.id, comment_id: comment.id, value: -1)
      redirect_to post, notice: "Vote added!"
    end
  end


end

