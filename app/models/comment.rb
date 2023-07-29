class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :lesson, counter_cache: true

  validates :content, presence: true, length: { minimum: 5, maximum: 500 }
end
