class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :firstname, :surname, presence: true

  has_many :project_members, dependent: :destroy
  has_many :projects, through: :project_members
  enum status: {
        user: 0,
        administrator: 1
  }
end
