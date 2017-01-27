class User < ActiveRecord::Base
  acts_as_paranoid

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :tickets, :dependent => :destroy

  validates :fullname, length: { maximum: 30 }
  validates :phone, length: { maximum: 15 }, numericality: true, allow_blank: true
end
