require 'rails_helper'

RSpec.describe User, type: :model do

  it "should require a email" do
    should validate_presence_of(:email)
  end

  it "should require a password" do
    should validate_presence_of(:password)
  end

  it 'email with valid format' do
    should allow_value("test@test").for(:email)
    should allow_value("test123@test.com").for(:email)
  end

  it 'email with invalid format' do
    should_not allow_value("test").for(:email)
  end

  it 'password with minimum length' do
    should validate_length_of(:password).is_at_least(6)
  end

  it 'password validate with confirmation' do
    should validate_confirmation_of(:password)
  end

end
