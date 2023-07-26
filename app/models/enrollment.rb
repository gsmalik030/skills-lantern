class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :course, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true, uniqueness: { scope: :course }

  validate :cant_subscribe_to_own_course

  def to_s
    user.to_s + " " + course.to_s
  end
  protected
  def cant_subscribe_to_own_course
    if self.new_record?
      if self.user.present?
        errors.add(:base, "You can't subscribe to your own course") if course.user == user
      end
    end
  end

end
