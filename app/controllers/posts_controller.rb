class PostsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:posts)
  expose_decorated(:post)
  expose_decorated(:comments) { post.comments }
#  expose_decorated(:comments, finder: :find_by_slug)

  def index
  end

  # def new
  # end

  # def edit
  # end

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
    if post.user != current_user
      self.comments = post.comments.where(abusive: false)
    end
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
