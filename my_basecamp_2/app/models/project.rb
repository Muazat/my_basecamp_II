class Project < ApplicationRecord
    validates :title, :description, presence: true
    has_many :project_members, dependent: :destroy
    has_many :users, through: :project_members
    has_many :discussions, dependent: :destroy
    has_many_attached :files
end
