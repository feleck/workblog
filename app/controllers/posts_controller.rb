class PostsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:posts)
  expose_decorated(:post)
  expose_decorated(:comments) { post.comments }

  def index
  end

  def new
  end

  def edit
  end

  def update
    if post.save
      render action: :index
    else
      render :new
    end
  end

  def destroy
    post.destroy if current_user.owner? post
    render action: :index
  end

  def show

    @komments = Array.new(post.comments)
    @komments.each do |kom|
      if kom.abusive && post.user != current_user
        @komments.delete(kom)
      else
        
      end
    end
#   @komment = Comment.new
#   comments = post.comments
#    post.comments.each do |comment|
#      if comment.abusive && post.user != current_user
#        #post.comments.delete(comment)
#      end
#    end
   
  end

  def mark_archived
    post.archive!
    render action: :index
  end

  def create
    post.user_id = current_user.id
    if post.save
      redirect_to action: :index
    else
      render :new
    end
  end

end
