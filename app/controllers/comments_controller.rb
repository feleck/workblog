class CommentsController < ApplicationController
  before_filter :authenticate_user!
  #expose_decorated(:comment)  
  #expose_decorated(:comments)
  
  def create
    @post = Post.find(params[:post_id])
    
    @vote = Vote.new()
    @comment = @post.comments.create(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
    end
  #  if comment.create()
  #    redirect_to post_path(post)
  #  end
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
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    #@post = Post.find(params[:post_id])

    #@comment = comment #Comment.find(params[:comment_id])
#    @post = comment.post
#    @vote = Vote.create(params[:comment])
#    if @vote.user_id == current_user.id
      # can not add more than one vote
      # js info - You already voted!
#    end
#    @vote.vote_up_count += 1
#    @vote.user_id = current_user.id
#    #@votes = @comment.votes
    
    redirect_to post_path(@post)
  end

  def vote_down
    
  end


end
