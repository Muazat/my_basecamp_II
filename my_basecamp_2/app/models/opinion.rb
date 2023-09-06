class Opinion < ApplicationRecord
    belongs_to :discussion, foreign_key: "discussion_id"
end
