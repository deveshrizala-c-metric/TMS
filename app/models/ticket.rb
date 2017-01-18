class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :issue_summary

  acts_as_paranoid

  has_attached_file :image

  resourcify

  validates :issue_details, presence: true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :image, :less_than => 10.megabytes
end
