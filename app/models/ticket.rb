class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :issue_summary, class_name: IssueSummary
  has_many :posts, :dependent => :destroy

  acts_as_paranoid

  has_attached_file :image

  resourcify

  sanitizes :issue_details, on: :create

  scope :filter_tickets_by_status, -> (status) {
    if User.current.has_role? :admin
      includes(:user,:department,:issue_summary).where(status: status).pluck(:id, "departments.name", "issue_summaries.name", :priority, :email, :location, :created_at).map { |e| [ e[0],e[1],e[2],e[3],e[4],e[5],e[6].strftime("%d/%m/%Y") ] }
    else
      includes(:user,:department,:issue_summary).where(status: status).pluck(:id, "departments.name", "issue_summaries.name", :priority, :created_at).map { |e| [ e[0],e[1],e[2],e[3],e[4].strftime("%d/%m/%Y") ] }
    end
  }
  scope :filter_deleted_tickets_by_status, -> (status) {
    if User.current.has_role? :admin
      includes(:user,:department,:issue_summary).where(status: status).pluck(:id, "departments.name", "issue_summaries.name" , :priority, :email, :deleted_at).map { |e| [ e[0],e[1],e[2],e[3],e[4],e[5].strftime("%d/%m/%Y") ] }
    else
      includes(:user,:department,:issue_summary).where(status: status).pluck(:id, "departments.name", "issue_summaries.name" , :priority, :deleted_at).map { |e| [ e[0],e[1],e[2],e[3],e[4].strftime("%d/%m/%Y") ] }
    end
  }

  validates :department, presence: true
  validates :issue_summary, presence: true
  validates :issue_details, presence: true, length: { maximum: 255 }
  validates :location, presence: true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :image, :less_than => 5.megabytes

end
