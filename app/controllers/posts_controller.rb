class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @ticket = Ticket.find(params[:post][:ticket_id])

    if params.permit!
      respond_to do |format|
        @post = @ticket.posts.new(params[:post])
        if @post.save
          flash[:success] = 'Post created successfully'
          format.html { redirect_to @ticket }
        else
          flash[:danger] = @post.errors.full_messages.to_sentence
          format.html { redirect_to ticket_path(@ticket) }
        end
      end
    end
  end
end
