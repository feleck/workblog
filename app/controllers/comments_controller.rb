class CommentsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:posts)
  expose_decorated(:post)
  expose_decorated(:comments)
  
  def create
  #  @post = Post.find(params[:post_id])
  #  @comment = @post.comments.create(params[:comment])
  #  redirect_to post_path(@post)
    redirect_to post_path(post)
  end

  def mark_as_not_abusive
    
  end

  def vote_up
    
  end
end
