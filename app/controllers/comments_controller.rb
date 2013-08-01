class CommentsController < ApplicationController
  before_filter :authenticate_user!
  #expose_decorated(:comment)  
  #expose_decorated(:comments)
  
  def create
    @post = Post.find(params[:post_id])
#    @comments = @post.comments
#    @vote = Vote.new()
# poprawić, żeby bez pustych commentów
    @comment = @post.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post)
    end
  end

  def mark_as_not_abusive    
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.abusive = false
    if @comment.save
      redirect_to post_path(@post)
    else

    end
  end

  def vote_up
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @user = @comment.user
    if @comment.votes.empty?
      @vote = Vote.create(user_id: @user.id, comment_id: @comment.id)
    end

    if Vote.find_by(@user.id)
      # flash (Cannot vote for this post again)
    else

    end
    #@vote = 
    @vote = Vote.create(user_id: @user.id, comment_id: @comment.id)
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
