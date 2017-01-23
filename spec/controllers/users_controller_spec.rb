require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:example) do
    User.delete_all
    @user = FactoryGirl.create(:user)
    @user.confirm
  end

  let(:valid_attributes) {
    FactoryGirl.create(:user)
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all users as @users" do
      user = valid_attributes
      user.confirm
      user.add_role :admin
      sign_in user
      get :index, params: {}, session: valid_session
      expect(assigns(:users)).to eq([@user])
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      valid_attributes.confirm
      valid_attributes.add_role :admin

      sign_in valid_attributes
      get :show, id: @user.id, session: valid_session
      expect(assigns(:user)).to eq(@user)
    end
  end

  describe "DELETE #destroy & GET #deleted" do
    it "destroys the requested user" do
      valid_attributes.confirm
      valid_attributes.add_role :admin

      sign_in valid_attributes
      expect {
        delete :destroy, id: @user.id, session: valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the deleted user list" do
      valid_attributes.confirm
      valid_attributes.add_role :admin

      sign_in valid_attributes
      delete :destroy, id: @user.id, session: valid_session
      expect(response).to redirect_to(deleted_users_url)
    end
  end

  describe "GET #restore" do
    it "restore the requested user" do
      valid_attributes.confirm
      valid_attributes.add_role :admin

      sign_in valid_attributes
      delete :destroy, id: @user.id, session: valid_session
      get :restore, id: @user.id, session: valid_session
      expect(response).to redirect_to(users_url)
    end
  end
end
