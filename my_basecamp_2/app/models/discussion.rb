class Discussion < ApplicationRecord
    has_many :opinions, dependent: :destroy
    belongs_to :project, foreign_key: "project_id"
end
