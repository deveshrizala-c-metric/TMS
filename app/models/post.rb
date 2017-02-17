class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket

  sanitizes :description, on: :create

  validates :description, presence: true, length: { maximum: 255 }, on: :create
end
