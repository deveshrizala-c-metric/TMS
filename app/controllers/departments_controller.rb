class DepartmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    respond_to do |format|
      if @department.save
        flash[:success] = 'Department created successfully'
        format.html { redirect_to departments_path }
      else
        flash[:danger] = 'There is a problem in creating the department'
        format.html { render :new }
      end
    end
  end

  def show
    @department = Department.find(params[:id])
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.update_attributes(department_params)
        flash[:success] = 'Department was successfully updated.'
        format.html { redirect_to @department }
      else
        flash[:danger] = 'There was a problem updating the department.'
        format.html { render :edit }
      end
    end
  end

  def destroy
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.destroy
        flash[:success] = 'Department was successfully deleted.'
        format.html { redirect_to deleted_departments_path }
      else
        flash[:danger] = 'There was a problem deleting the department.'
        format.html { redirect_to departments_path }
      end
    end
  end

  def deleted
    @departments = Department.only_deleted
  end

  def restore
    @department = Department.only_deleted.find(params[:id])

    respond_to do |format|
      if Department.restore(@department.id)
        flash[:success] = 'Department restored successfully'
        format.html { redirect_to departments_path }
      else
        flash[:danger] = 'There is a problem in restoring the department.'
        format.html { redirect_to departments_path }
      end
    end
  end

  private
  def department_params
    params.require(:department).permit(:name)
  end

end
