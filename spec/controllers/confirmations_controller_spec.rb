require 'rails_helper'

RSpec.describe Users::ConfirmationsController, type: :controller do

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #new" do
    it "responds successfully with HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders new page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    it "should deliver the signup email" do
      @user = FactoryGirl.create(:user)
      post :create, "user" => { "email" => @user.email, "fullname" => @user.fullname }
      expect(@user).to redirect_to(new_user_session_path)
    end
  end
end
