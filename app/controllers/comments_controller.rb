class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    
    @vote = Vote.new
    @comment = @post.comments.create(params[:comment])
    @comment.user_id = current_user.id
    #if comment.save
    if @comment.save
     # redirect_to post_path(@post)
     redirect_to @post, notice: "Comment created!"
     #render @post
    else
      #flash[:error] = "Smth went wrong"
      #redirect_to post_path(@post)
      #render @post
      redirect_to @post, flash: { error: "Can't add empty comment!" } #:flash => { :error => "Insufficient rights!" }
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
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    votes = comment.votes
    if !votes.empty?
      votes.each do |vote|
        if vote.user_id == current_user.id
          redirect_to post, flash: { error: "Can't vote again!" }
        else
          Vote.create(user_id: current_user.id, comment_id: comment.id, value: 1)
          redirect_to post
        end
      end
    else
      Vote.create(user_id: current_user.id, comment_id: comment.id, value: 1)
      redirect_to post
    end
  end


  def vote_down
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    votes = comment.votes
    #votes_down = 
    if !votes.empty?
      votes.each do |vote|
        if vote.value == -1
          votes_down += 1
          dupa
        end
        if vote.user_id == current_user.id
          redirect_to post, flash: { error: "Can't vote again!" }
        else
          Vote.create(user_id: current_user.id, comment_id: comment.id, value: -1)
          votes_down += 1
          if votes_down >= 3
            comment.abusive = true
            comment.save
          end
          redirect_to post
        end
      end
    else
      Vote.create(user_id: current_user.id, comment_id: comment.id, value: -1)
      redirect_to post
    end
  end

end

