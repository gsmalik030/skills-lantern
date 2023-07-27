class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :course, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true, uniqueness: { scope: :course }

  validate :cant_subscribe_to_own_course
  validates :rating, presence: true, if: -> { review.present? }
  validates :review, presence: true, if: -> { rating.present? }

  scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""]) }

  def self.ransackable_attributes(auth_object = nil)
    ["course_id", "created_at", "id", "price", "rating", "review", "slug", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["course", "user"]
  end

  def to_s
    user.to_s + " " + course.to_s
  end

  after_save do
    unless rating.nil? || rating.zero?
      course.update_rating
    end
  end

  after_destroy do
    course.update_rating
  end

  extend FriendlyId
  friendly_id :to_s, use: :slugged
  protected
  def cant_subscribe_to_own_course
    if self.new_record?
      if self.user.present?
        errors.add(:base, "You can't subscribe to your own course") if course.user == user
      end
    end
  end

end
