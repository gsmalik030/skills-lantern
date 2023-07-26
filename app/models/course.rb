class Course < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { minimum: 5, maximum: 150 }
    validates :description, presence: true, length: { minimum: 5 }
    validates :short_description, presence: true, length: { minimum: 5, maximum: 150 }
    validates :language, :level, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    
    has_rich_text :description

    def to_s
        title
    end

    extend FriendlyId
    friendly_id :title, use: :slugged
end
