class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  has_many :user_lessons, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5, maximum: 150 }, uniqueness: { scope: :course_id}
  validates :content, presence: true, length: { minimum: 5}
  validates :course, presence: true

  def video_attached?
    self.video.present?
  end

  has_one_attached :video
  has_one_attached :thumbnail
  has_rich_text :content

  validates :video, content_type: ['video/mp4'], size: { between: 1.kilobyte..50.megabytes , message: 'Size should be less than 50mb' }
  validates :thumbnail, content_type: ['image/png', 'image/jpeg', 'image/jpg'], size: { less_than: 50.megabytes , message: 'Size should be less than 500kb' }


  include RankedModel
  ranks :row_order, with_same: :course_id

  extend FriendlyId
  friendly_id :title, use: :slugged

  def to_s
    title
  end 

  def prev_lesson
    course.lessons.where("row_order < ?", row_order).last
  end

  def next_lesson
    course.lessons.where("row_order > ?", row_order).first
  end

  def completed(user)
    self.user_lessons.where(user: user).present?
  end

end
