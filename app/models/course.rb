class Course < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { minimum: 5, maximum: 150 }
    validates :description, presence: true, length: { minimum: 5 }
    validates :short_description, presence: true, length: { minimum: 5, maximum: 150 }
    validates :language, :level, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    
    has_rich_text :description

    extend FriendlyId
    friendly_id :title, use: :slugged

    def to_s
        title
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "language", "level", "price", "short_description", "slug", "title", "updated_at", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["rich_text_description", "user"]
    end

    LANGUAGES = [:English,  :Arabic, :French, :Urdu, :Hindi]
    def self.languages
        LANGUAGES.map { |language| [language, language] }
    end

    LEVELS = [:Beginner,  :Intermediate, :Advanced]
    def self.levels
        LEVELS.map { |level| [level, level] }
    end

end
