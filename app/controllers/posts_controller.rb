class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @ticket = Ticket.find(params[:post][:ticket_id])

    if params.permit!
      respond_to do |format|
        if @ticket.posts.new(params[:post]).blank? == false
         flash[:danger] = "Post can't be blank"
         format.html { redirect_to @ticket }
        else
          if @ticket.posts.new(params[:post]).save
            flash[:success] = 'Post created successfully'
            format.html { redirect_to @ticket }
          else
            flash[:danger] = 'There is a problem in creating the post'
            format.html { redirect_to @ticket }
          end
        end
      end
    end
  end
end
