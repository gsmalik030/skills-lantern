class UserLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validates :user, presence: true, if: -> { lesson.present? }
  validates :lesson, presence: true, if: -> { user.present? }
end