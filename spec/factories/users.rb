require 'ffaker'

FactoryGirl.define do
  factory :user do
    fullname FFaker::Name.name
    phone "9988776655"
    email { FFaker::Internet.email }
    password "secret"
    password_confirmation "secret"

    factory :user_with_ticket do
      after(:create) do |user|
        # after(:create) do |department|
        #   after(:create) do |issue_summary|
            create(:ticket, user: user)
        #   end
        # end
      end
    end
  end
end
