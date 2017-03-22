class DepartmentsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)

    @department[:name] = @department[:name].gsub(/\s+/, "")

    respond_to do |format|
      if @department.valid? == false
       flash.now[:danger] = @department.errors.full_messages.to_sentence
       format.html { render :new }
      else
        dep = Department.where("name = ?", @department[:name])
        dd = Department.only_deleted.where("name = ?", @department[:name])

        if dep.present? or dd.present?
          flash.now[:danger] = 'Department already exist'
          format.html { render :new }
        else
          if @department.save
            flash[:success] = 'Department created successfully'
            format.html { redirect_to departments_path }
          else
            flash[:danger] = 'There is a problem in creating the department'
            format.html { render :new }
          end
        end
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
        flash[:success] = 'Department updated successfully'
        format.html { redirect_to @department }
      else
        flash.now[:danger] = @department.errors.full_messages.to_sentence
        format.html { render :edit }
      end
    end
  end

  def destroy
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.destroy
        flash[:success] = 'Department deleted successfully '
        format.html { redirect_to deleted_departments_path }
      else
        flash[:danger] = 'There is a problem in deleting the department.'
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
