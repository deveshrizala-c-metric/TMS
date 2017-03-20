class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :issue_summary
  has_many :posts, :dependent => :destroy

  acts_as_paranoid

  has_attached_file :image

  resourcify

  sanitizes :issue_details, on: :create

  validates :department, presence: true
  validates :issue_summary, presence: true
  validates :issue_details, presence: true, length: { maximum: 255 }
  validates :location, presence: true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :image, :less_than => 5.megabytes
end
