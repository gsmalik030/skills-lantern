class User < ApplicationRecord
  
  has_many :courses, dependent: :nullify
  has_many :enrollments, dependent: :nullify
  has_many :user_lessons, dependent: :nullify
  has_many :comments, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
    def to_s
      email
    end

    def self.ransackable_attributes(auth_object = nil)
      ["confirmation_sent_at", "confirmation_token", "confirmed_at", "created_at", "current_sign_in_at", "current_sign_in_ip", "email", "id", "last_sign_in_at", "last_sign_in_ip", "remember_created_at", "reset_password_sent_at", "reset_password_token", "sign_in_count", "unconfirmed_email", "updated_at"]
    end
    rolify
    def username
      if email.present?
        email.split("@").first
      end
    end

    extend FriendlyId
    friendly_id :email, use: :slugged

    after_create :assign_default_role

    def assign_default_role
      if User.count == 1
        self.add_role(:admin) if self.roles.blank?
        self.add_role(:teacher)
        self.add_role(:student)
      else
        self.add_role(:student) if self.roles.blank?
        self.add_role(:teacher)
      end
    end

    validate :must_have_role, on: :update

    def online?
      updated_at > 1.minutes.ago
    end

    def buy_course(course)
      self.enrollments.create(course: course, price: course.price)
    end

    def completed_lesson(lesson)
      user_lesson = self.user_lessons.where(lesson: lesson)
      if user_lesson.any?
        user_lesson.first.increment!(:impressions)
      else
      end
    end

    private
    def must_have_role
      unless roles.any?
        errors.add(:roles, "must have at least one role")
      end
    end
end
