class IssuesummariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @issue_sums = IssueSummary.all
  end

  def new
    @issue_sum = IssueSummary.new
  end

  def create
    @issue_sum = IssueSummary.new(issue_sum_params)
    respond_to do |format|
      if @issue_sum.save
        flash[:success] = 'Issue_Summary created successfully'
        format.html { redirect_to issuesummaries_path }
      else
        flash[:danger] = 'There is a problem in creating the issue_summary'
        format.html { render :new }
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
      if @issue_sum.update_attributes(issue_sum_params)
        flash[:success] = 'IssueSummary was successfully updated.'
        format.html { redirect_to issuesummary_path }
      else
        flash[:danger] = 'There was a problem updating the issuesummary.'
        format.html { render :edit }
      end
    end
  end

  def destroy
    @issue_sum = IssueSummary.find(params[:id])

    respond_to do |format|
      if @issue_sum.destroy
        flash[:success] = 'IssueSummary was successfully deleted.'
        format.html { redirect_to deleted_issuesummaries_path }
      else
        flash[:danger] = 'There was a problem deleting the department.'
        format.html { redirect_to issuesummaries_path }
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
        flash[:success] = 'IssueSummary restored successfully'
        format.html { redirect_to issuesummaries_path }
      else
        flash[:danger] = 'There is a problem in restoring the issuesummary.'
        format.html { redirect_to issuesummaries_path }
      end
    end
  end

  private
  def issue_sum_params
    params.require(:issue_summary).permit(:name)
  end
end
