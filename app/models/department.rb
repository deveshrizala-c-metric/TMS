class Department < ActiveRecord::Base
  has_many :tickets, :dependent => :destroy

  acts_as_paranoid

  validates :name, presence: true, length: { maximum: 20 }, on: [:create, :update]
end
