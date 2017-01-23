class Department < ActiveRecord::Base
  has_many :tickets

  acts_as_paranoid

  validates :name, presence: true
end
