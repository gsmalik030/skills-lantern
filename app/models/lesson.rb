class Lesson < ApplicationRecord
  belongs_to :course

  validates :title, presence: true, length: { minimum: 5, maximum: 150 }
  validates :content, presence: true, length: { minimum: 5}
  validates :course, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged

end
