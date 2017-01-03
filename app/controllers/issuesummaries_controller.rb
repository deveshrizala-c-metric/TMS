class IssuesummariesController < ApplicationController
  def index
    @issue_sums = IssueSummary.all
  end

  def new
    @issue_sum = IssueSummary.new
  end

  def create
    @issue_sum = IssueSummary.new(issue_sum_params)
  end

  def show
    @issue_sum = IssueSummary.find(params[:id])
  end

  def edit
    @issue_sum = IssueSummary.find(params[:id])
  end

  def update
    @issue_sum = IssueSummary.find(params[:id])
    @issue_sum.update_attributes(issue_sum_params)
  end

  def destroy
    @issue_sum = IssueSummary.find(params[:id])
    @issue_sum.destroy
  end

  private
  def issue_sum_params
    params.require(:issue_summary).permit(:name)
  end
end
