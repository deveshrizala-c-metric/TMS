require 'ffaker'

FactoryGirl.define do
  factory :user do
    fullname FFaker::Name.name
    phone "9988776655"
    email { FFaker::Internet.email }
    password "secret"
    password_confirmation "secret"
  end
end
