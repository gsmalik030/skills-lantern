class UserLesson < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :lesson, counter_cache: true

  validates :user, presence: true, if: -> { lesson.present? }
  validates :lesson, presence: true, if: -> { user.present? }
end