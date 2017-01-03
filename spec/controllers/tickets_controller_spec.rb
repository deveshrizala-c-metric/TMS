require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:valid_attributes) {
    FactoryGirl.create(:user_with_ticket)
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all tickets as @tickets" do
      user_with_ticket = valid_attributes
      sign_in user_with_ticket
      get :index, params: {}, session: valid_session
      expect(assigns(:tickets)).to eq(user_with_ticket.tickets)
    end
  end

  describe "GET #new" do
    it "assigns a new ticket as @ticket" do
      user_with_ticket = valid_attributes
      sign_in user_with_ticket
      get :new, params: {}, session: valid_session
      expect(assigns(:ticket)).to be_a_new(Ticket)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Ticket" do
        expect {
          post :create, params: {ticket: valid_attributes}, session: valid_session
        }.to change(Ticket, :count).by(1)
      end

      it "assigns a newly created ticket as @ticket" do
        user_with_ticket = valid_attributes
        sign_in user_with_ticket
        post :create, ticket: FactoryGirl.attributes_for(:ticket), session: valid_session
        expect(assigns(:ticket)).to be_a(Ticket)
        expect(assigns(:ticket)).to be_persisted
      end

      it "redirects to the created ticket" do
        user_with_ticket = valid_attributes
        sign_in user_with_ticket
        post :create, ticket: FactoryGirl.attributes_for(:ticket), session: valid_session
        expect(response).to redirect_to(tickets_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved ticket as @ticket" do
        user_with_ticket = valid_attributes
        sign_in user_with_ticket
        post :create, ticket: FactoryGirl.attributes_for(:ticket, :issue_details => nil), session: valid_session
        expect(assigns(:ticket)).to be_a_new(Ticket)
      end

      it "re-renders the 'new' template" do
        user_with_ticket = valid_attributes
        sign_in user_with_ticket
        post :create, ticket: FactoryGirl.attributes_for(:ticket, :issue_details => nil), session: valid_session
        expect(response).to redirect_to(new_ticket_path)
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested ticket as @ticket" do
      user_with_ticket = valid_attributes
      sign_in user_with_ticket
      get :show, id: user_with_ticket.tickets.first.id, session: valid_session
      expect(assigns(:ticket)).to eq(user_with_ticket.tickets.first)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested ticket" do
      user_with_ticket = valid_attributes
      sign_in user_with_ticket
      expect {
        delete :destroy, id: user_with_ticket.tickets.first.id, session: valid_session
      }.to change(Ticket, :count).by(-1)
    end

    it "redirects to the tickets list" do
      user_with_ticket = valid_attributes
      sign_in user_with_ticket
      delete :destroy, id: user_with_ticket.tickets.first.id, session: valid_session
      expect(response).to redirect_to(tickets_url)
    end
  end
end
