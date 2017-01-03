class TicketsController < ApplicationController
  before_action :authenticate_user!

  # before_action :reload_page,  only: [:edit]

  def index
    @tickets = Ticket.where("user_id = ? ", current_user.id)
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
        flash[:danger] = 'There is a problem in creating the Ticket'
        format.html { redirect_to new_ticket_path }
      end
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  # def edit
  #   @ticket = Ticket.find(params[:id])
  # end

  # def update
  #   @ticket = Ticket.find(params[:id])

  #   respond_to do |format|
  #     if @ticket.update_attributes(ticket_params)
  #       flash[:success] = 'Ticket updated successfully'
  #       format.html { redirect_to tickets_path }
  #     else
  #       flash[:danger] = 'There is a problem in updating the Ticket'
  #       format.html { render :edit }
  #     end
  #   end
  # end

  def destroy
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.destroy
        flash[:success] = 'Ticket deleted successfully'
        format.html { redirect_to tickets_path }
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

  private
  def ticket_params
    params.require(:ticket).permit(:department_id,:issue_summary_id,:issue_details,:image,:location)
  end
end
