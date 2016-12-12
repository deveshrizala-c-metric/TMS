require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  user = FactoryGirl.create(:user)
  user.confirm
  raw = user.send_reset_password_instructions

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

  describe "GET #edit" do

    it "responds successfully with HTTP 200 status code" do
      get :edit, reset_password_token: raw
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "invalid reset password token status code" do
      get :edit, reset_password_token: nil
      expect(user).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #update" do

    it "reset password with valid params" do
      get :edit, reset_password_token: raw
      put :update, "user" => {
        :reset_password_token => raw, :password => "1234567", :password_confirmation => "1234567"
      }
      expect(response).to redirect_to(root_path)
    end

    it "reset password with invalid params" do
      put :update, "user" => {
        "reset_password_token" => raw, "password" => "1234567", "password_confirmation" => "12345678"
      }
      expect(response).to render_template("edit")
    end

    it "reset password with invalid reset_password_token" do
      put :update, "user" => {
        "reset_password_token" => nil, "password" => "1234567", "password_confirmation" => "1234567"
      }
      expect(response).to render_template("edit")
    end
  end
end