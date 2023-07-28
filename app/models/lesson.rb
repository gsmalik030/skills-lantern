class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  has_many :user_lessons, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5, maximum: 150 }
  validates :content, presence: true, length: { minimum: 5}
  validates :course, presence: true

  has_rich_text :content

  include RankedModel
  ranks :row_order, with_same: :course_id

  extend FriendlyId
  friendly_id :title, use: :slugged

  def to_s
    title
  end 

  def completed(user)
    self.user_lessons.where(user: user).present?
  end

end
