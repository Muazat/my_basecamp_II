class ProjectMember < ApplicationRecord
    enum status: {
        member: 0,
        admin: 1
    }
    belongs_to :project, foreign_key: "project_id"
    belongs_to :user, foreign_key: "user_id"

    validates :user_id, uniqueness: {scope: :project_id }
    # Ex:- scope :active, -> {where(:active => true)}}
end
