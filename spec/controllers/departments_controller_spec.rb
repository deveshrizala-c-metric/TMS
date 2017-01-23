require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.confirm
    @user.add_role :admin
  end

  let(:valid_attributes) {
    FactoryGirl.create(:department)
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all departments as @departments" do
      sign_in @user
      get :index, params: {}, session: valid_session
      expect(assigns(:departments)).to eq([valid_attributes])
    end
  end

  describe "GET #new" do
    it "assigns a new department as @department" do
      sign_in @user
      get :new, params: {}, session: valid_session
      expect(assigns(:department)).to be_a_new(Department)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Department" do
        expect {
          post :create, params: {department: valid_attributes}, session: valid_session
        }.to change(Department, :count).by(1)
      end

      it "assigns a newly created department as @department" do
        sign_in @user
        post :create, department: FactoryGirl.attributes_for(:department), session: valid_session
        expect(assigns(:department)).to be_a(Department)
        expect(assigns(:department)).to be_persisted
      end

      it "redirects to the created department" do
        sign_in @user
        post :create, department: FactoryGirl.attributes_for(:department), session: valid_session
        expect(response).to redirect_to(departments_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved department as @department" do
        sign_in @user
        post :create, department: FactoryGirl.attributes_for(:department, :name => nil), session: valid_session
        expect(assigns(:department)).to be_a_new(Department)
      end

      it "re-renders the 'new' template" do
        sign_in @user
        post :create, department: FactoryGirl.attributes_for(:department, :name => nil), session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested department as @department" do
      sign_in @user
      department = valid_attributes
      get :show, id: department.to_param, session: valid_session
      expect(assigns(:department)).to eq(department)
    end
  end

  describe "GET #edit" do
    it "assigns the requested department as @department" do
      sign_in @user
      department = valid_attributes
      get :edit, id: department.to_param, session: valid_session
      expect(assigns(:department)).to eq(department)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "assigns the requested department as @department" do
        sign_in @user
        department = valid_attributes
        put :update, id: department.to_param, department: FactoryGirl.attributes_for(:department), session: valid_session
        expect(assigns(:department)).to eq(department)
      end

      it "redirects to the department" do
        sign_in @user
        department = valid_attributes
        put :update, id: department.to_param, department: FactoryGirl.attributes_for(:department), session: valid_session
        expect(response).to redirect_to(department_url)
      end
    end

    context "with invalid params" do
      it "assigns the department as @department" do
        sign_in @user
        department = valid_attributes
        put :update, id: department.to_param, department: FactoryGirl.attributes_for(:department, :name => nil), session: valid_session
        expect(assigns(:department)).to eq(department)
      end

      it "re-renders the 'edit' template" do
        sign_in @user
        department = valid_attributes
        put :update, id: department.to_param, department: FactoryGirl.attributes_for(:department, :name => nil), session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy & GET #deleted" do
    it "destroys the requested department" do
      sign_in @user
      department = valid_attributes
      expect {
        delete :destroy, id: department.to_param, session: valid_session
      }.to change(Department, :count).by(-1)
    end

    it "redirects to the deleted departments list" do
      sign_in @user
      department = valid_attributes
      delete :destroy, id: department.to_param, session: valid_session
      expect(response).to redirect_to(deleted_departments_url)
    end
  end

  describe "GET #restore" do
    it "restore the requested user" do
      sign_in valid_attributes
      department = valid_attributes
      delete :destroy, id: department.id, session: valid_session
      get :restore, id: department.id, session: valid_session
      expect(response).to redirect_to(departments_url)
    end
  end
end
