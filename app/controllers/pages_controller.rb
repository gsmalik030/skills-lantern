class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :privacy_policy]
  def home
    @courses = Course.all.limit(3).order(created_at: :desc).is_approved.is_published
    @recent_courses = Course.all.limit(3).order(created_at: :desc).is_approved.is_published
    @best_reviews = Enrollment.reviewed.all.limit(3).order(rating: :desc, created_at: :desc)
    @top_rated_courses = Course.all.limit(3).order(average_rating: :desc, created_at: :desc).is_approved.is_published
    @popular_courses = Course.all.limit(3).order(enrollments_count: :desc, created_at: :desc).is_approved.is_published
    @enrolled_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).limit(3).order(created_at: :desc)
  end
  def privacy_policy
  end
end
