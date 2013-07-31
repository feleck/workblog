class CommentsController < ApplicationController
  #before_filter :authenticate_user!
  expose_decorated(:post)
  expose_decorated(:comment)

  def create
    if comment.save
      redirect_to post_path(post)
    else
     #render :show
    end
  end

  def mark_as_not_abusive
    
  end

  def vote_up
    
  end
end
