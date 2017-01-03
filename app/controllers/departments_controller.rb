class DepartmentsController < ApplicationController

  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
  end

  def show
    @department = Department.find(params[:id])
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    @department.update_attributes(department_params)
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy
  end

  private
  def department_params
    params.require(:department).permit(:name)
  end

end
