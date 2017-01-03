class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :tickets

  # validates :phone, :numericality => true, :length => { :minimum => 10, :maximum => 15 }
  # validates_format_of :phone, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"
end
