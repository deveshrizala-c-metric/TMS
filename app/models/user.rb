class User < ActiveRecord::Base
  acts_as_paranoid

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :tickets, :dependent => :destroy
  has_many :posts, :dependent => :destroy

  validates :fullname, length: { maximum: 30 }
  validates :phone, length: { maximum: 15 }, numericality: true, allow_blank: true
  validates :email, format: { :with => /(([A-Za-z])\w*(\.?|\-?|\+))+@{1}(([A-Za-z])\w+\.{1}){1,2}([A-Za-z])\w+/, message: 'format is wrong.' }
  # before_validation_on_create :email, format: { :with => /(([A-Za-z])\w*(\.?|\-?|\+))+@{1}(([A-Za-z])\w+\.{1}){1,2}([A-Za-z])\w+/, message: 'Email format is wrong.' }, :before => :create
end
