class TicketsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource only: [:index, :new, :create, :show, :update_status, :destroy]

  def index
    if current_user.has_role? :admin
      @tickets = Ticket.all
    else
      @tickets = Ticket.where("user_id = ? ", current_user.id)
    end
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params.merge(user_id: current_user.id, status: "Open"))

    respond_to do |format|
      if @ticket.save
        flash[:success] = 'Ticket created successfully'
        format.html { redirect_to tickets_path }
      else
        flash[:danger] = 'There is a problem in creating the ticket'
        format.html { redirect_to new_ticket_path }
      end
    end
  end

  def show
    @ticket = Ticket.find(params[:id])

    @post = @ticket.posts.new

    @posts = @ticket.posts
  end

  def update_status
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_column(:status, params[:ticket][:status])
        flash[:success] = 'Status changed successfully'
        format.html { redirect_to tickets_path }
      else
        flash[:danger] = 'There is a problem in changing status'
        format.html { redirect_to ticket_path }
      end
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.destroy
        flash[:success] = 'Ticket deleted successfully'
        format.html { redirect_to deleted_tickets_path }
      else
        flash[:danger] = 'There is a problem in deleting the ticket.'
        format.html { redirect_to tickets_path }
      end
    end
  end

  def reload_page
    respond_to do |format|
      format.js {}
    end
  end

  def deleted
    if current_user.has_role? :admin
      @tickets = Ticket.only_deleted
    else
      @tickets = Ticket.only_deleted.where("user_id = ? ", current_user.id)
    end
  end

  def restore
    @ticket = Ticket.only_deleted.find(params[:id])

    respond_to do |format|
      if Ticket.restore(@ticket.id)
        flash[:success] = 'Ticket restored successfully'
        format.html { redirect_to tickets_path }
      else
        flash[:danger] = 'There is a problem in restoring the ticket.'
        format.html { redirect_to tickets_path }
      end
    end
  end

  private
  def ticket_params
    params.require(:ticket).permit(:department_id,:issue_summary_id,:issue_details,:image,:location)
  end
end
