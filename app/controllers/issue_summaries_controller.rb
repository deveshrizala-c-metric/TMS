class IssueSummariesController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    @issue_sums = IssueSummary.all
  end

  def new
    @issue_sum = IssueSummary.new
  end

  def create
    @issue_sum = IssueSummary.new(issue_summary_params)

    respond_to do |format|
      if @issue_sum.valid? == false
       flash[:danger] = @issue_sum.errors.full_messages.to_sentence
       format.html { redirect_to new_issue_summary_path }
      else
        is_sum = IssueSummary.where("name = ?", params[:issue_summary][:name])
        is_sum_del = IssueSummary.only_deleted.where("name = ?", params[:issue_summary][:name])

        if is_sum.present? or is_sum_del.present?
          flash[:danger] = 'Issue Summary already exist'
          format.html { render :new }
        else
          if @issue_sum.save
            flash[:success] = 'Issue Summary created successfully'
            format.html { redirect_to issue_summaries_path }
          else
            exit
            flash[:danger] = 'There is a problem in creating the Issue Summary'
            format.html { redirect_to new_issue_summary_path }
          end
        end
      end
    end
  end

  def show
    @issue_sum = IssueSummary.find(params[:id])
  end

  def edit
    @issue_sum = IssueSummary.find(params[:id])
  end

  def update
    @issue_sum = IssueSummary.find(params[:id])

    respond_to do |format|
      if @issue_sum.update_attributes(issue_summary_params)
        flash[:success] = 'Issue Summary updated successfully'
        format.html { redirect_to issue_summary_path }
      else
        flash.now[:danger] = @issue_sum.errors.full_messages.to_sentence
        format.html { render :edit }
      end
    end
  end

  def destroy
    @issue_sum = IssueSummary.find(params[:id])

    respond_to do |format|
      if @issue_sum.destroy
        flash[:success] = 'Issue Summary deleted successfully'
        format.html { redirect_to deleted_issue_summaries_path }
      else
        flash[:danger] = 'There is a problem in deleting the Issue Summary.'
        format.html { redirect_to issue_summaries_path }
      end
    end
  end

  def deleted
    @issue_sums = IssueSummary.only_deleted
  end

  def restore
    @issue_sum = IssueSummary.only_deleted.find(params[:id])

    respond_to do |format|
      if IssueSummary.restore(@issue_sum.id)
        flash[:success] = 'Issue Summary restored successfully'
        format.html { redirect_to issue_summaries_path }
      else
        flash[:danger] = 'There is a problem in restoring the Issue Summary.'
        format.html { redirect_to issue_summaries_path }
      end
    end
  end

  private
  def issue_summary_params
    params.require(:issue_summary).permit(:name)
  end
end
