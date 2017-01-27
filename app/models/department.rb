class Department < ActiveRecord::Base
  has_many :tickets, :dependent => :destroy

  acts_as_paranoid

  validates :name, presence: true, length: { maximum: 15 }, on: :create
end
