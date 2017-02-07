class Post < ActiveRecord::Base
  belongs_to :ticket

  sanitizes :description, on: :create
end
