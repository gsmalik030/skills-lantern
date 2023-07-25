class Course < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { minimum: 5, maximum: 150 }
    validates :description, presence: true, length: { minimum: 5 }
    has_rich_text :description

    def to_s
        title
    end
end