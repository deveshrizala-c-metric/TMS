FactoryGirl.define do
  factory :ticket do |f|
    f.issue_details "There is Software Problem"
    f.location "Ahemdabad"
    f.status "Open"
    f.association :department
    f.association :issue_summary
    Ticket.create(image: File.open("#{Rails.root}/spec/support/fixtures/ticket.jpeg"))
  end
end
