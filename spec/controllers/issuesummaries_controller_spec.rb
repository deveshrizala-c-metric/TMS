require 'rails_helper'

RSpec.describe IssuesummariesController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.confirm
    @user.add_role :admin
  end

  let(:valid_attributes) {
    FactoryGirl.create(:issue_summary)
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all issue_summaries as @issue_sums" do
      sign_in @user
      get :index, params: {}, session: valid_session
      expect(assigns(:issue_sums)).to eq([valid_attributes])
    end
  end

  describe "GET #new" do
    it "assigns a new issue_sum as @issue_sum" do
      sign_in @user
      get :new, params: {}, session: valid_session
      expect(assigns(:issue_sum)).to be_a_new(IssueSummary)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new IssueSummary" do
        expect {
          post :create, params: {issue_sum: valid_attributes}, session: valid_session
        }.to change(IssueSummary, :count).by(1)
      end

      it "assigns a newly created issue_sum as @issue_sum" do
        sign_in @user
        post :create, issue_summary: FactoryGirl.attributes_for(:issue_summary), session: valid_session
        expect(assigns(:issue_sum)).to be_a(IssueSummary)
        expect(assigns(:issue_sum)).to be_persisted
      end

      it "redirects to the created issue_summary" do
        sign_in @user
        post :create, issue_summary: FactoryGirl.attributes_for(:issue_summary), session: valid_session
        expect(response).to redirect_to(issuesummaries_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved issue_sum as @issue_sum" do
        sign_in @user
        post :create, issue_summary: FactoryGirl.attributes_for(:issue_summary, :name => nil), session: valid_session
        expect(assigns(:issue_sum)).to be_a_new(IssueSummary)
      end

      it "re-renders the 'new' template" do
        sign_in @user
        post :create, issue_summary: FactoryGirl.attributes_for(:issue_summary, :name => nil), session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested issue_sum as @issue_sum" do
      sign_in @user
      issue_sum = valid_attributes
      get :show, id: issue_sum.to_param, session: valid_session
      expect(assigns(:issue_sum)).to eq(issue_sum)
    end
  end

  describe "GET #edit" do
    it "assigns the requested issue_sum as @issue_sum" do
      sign_in @user
      issue_sum = valid_attributes
      get :edit, id: issue_sum.to_param, session: valid_session
      expect(assigns(:issue_sum)).to eq(issue_sum)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "assigns the requested issue_sum as @issue_sum" do
        sign_in @user
        issue_sum = valid_attributes
        put :update, id: issue_sum.to_param, issue_summary: FactoryGirl.attributes_for(:issue_summary), session: valid_session
        expect(assigns(:issue_sum)).to eq(issue_sum)
      end

      it "redirects to the issue_sum" do
        sign_in @user
        issue_sum = valid_attributes
        put :update, id: issue_sum.to_param, issue_summary: FactoryGirl.attributes_for(:issue_summary), session: valid_session
        expect(response).to redirect_to(issuesummary_url)
      end
    end

    context "with invalid params" do
      it "assigns the issue_sum as @issue_sum" do
        sign_in @user
        issue_sum = valid_attributes
        put :update, id: issue_sum.to_param, issue_summary: FactoryGirl.attributes_for(:issue_summary, :name => nil), session: valid_session
        expect(assigns(:issue_sum)).to eq(issue_sum)
      end

      it "re-renders the 'edit' template" do
        sign_in @user
        issue_sum = valid_attributes
        put :update, id: issue_sum.to_param, issue_summary: FactoryGirl.attributes_for(:issue_summary, :name => nil), session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy & GET #deleted" do
    it "destroys the requested issue_sum" do
      sign_in @user
      issue_sum = valid_attributes
      expect {
        delete :destroy, id: issue_sum.to_param, session: valid_session
      }.to change(IssueSummary, :count).by(-1)
    end

    it "redirects to the issue_sums list" do
      sign_in @user
      issue_sum = valid_attributes
      delete :destroy, id: issue_sum.to_param, session: valid_session
      expect(response).to redirect_to(deleted_issuesummaries_url)
    end
  end

  describe "GET #restore" do
    it "restore the requested user" do
      sign_in valid_attributes
      issue_sum = valid_attributes
      delete :destroy, id: issue_sum.id, session: valid_session
      get :restore, id: issue_sum.id, session: valid_session
      expect(response).to redirect_to(issuesummaries_url)
    end
  end
end
