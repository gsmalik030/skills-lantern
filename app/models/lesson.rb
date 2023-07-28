class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  has_many :user_lessons

  validates :title, presence: true, length: { minimum: 5, maximum: 150 }
  validates :content, presence: true, length: { minimum: 5}
  validates :course, presence: true

  has_rich_text :content

  extend FriendlyId
  friendly_id :title, use: :slugged

  def to_s
    title
  end 

  def completed(user)
    self.user_lessons.where(user: user).present?
  end

end
