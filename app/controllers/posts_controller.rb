class PostsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: PostsDatatable.new(view_context) }
    end
  end

  def show
    @post = Post.published.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
end
