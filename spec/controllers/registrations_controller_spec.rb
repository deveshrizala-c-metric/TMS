require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do

  let(:valid_attributes) {
    FactoryGirl.create(:user)
  }

  let(:invalid_attributes) {
    FactoryGirl.create(:user, email: nil, password: nil)
  }

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

    it "assigns a new user as @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to be_a(User)
        # expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created user" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, user: FactoryGirl.attributes_for(:user, :email => nil)
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, user: FactoryGirl.attributes_for(:user, :email => nil)
        expect(response).to render_template("new")
      end
    end
  end
end
