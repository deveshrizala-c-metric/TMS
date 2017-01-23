class IssueSummary < ActiveRecord::Base
  has_many :tickets, :dependent => :destroy

  acts_as_paranoid

  validates :name, presence: true
end
