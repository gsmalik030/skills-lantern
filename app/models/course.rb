class Course < ApplicationRecord
    belongs_to :user, counter_cache: true
    has_many :lessons, dependent: :destroy
    has_many :user_lessons, through: :lessons
    has_many :enrollments, dependent: :restrict_with_error
    validates :title, presence: true, length: { minimum: 5, maximum: 150 }, uniqueness: true
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

    def progress_in_percentage(user)
        unless self.lessons_count.zero?
          (user_lessons.where(user: user).count / lessons.count).to_f * 100
        end
    end

    def enrolled(user)
        self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
    end

    def update_rating
        if enrollments.any? && enrollments.where.not(rating: [nil, 0]).any?
            update_column :average_rating, enrollments.average(:rating).round(2).to_f
        else
            update_column :average_rating, 0
        end
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
