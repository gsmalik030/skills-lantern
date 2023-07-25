class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :privacy_policy]
  def home
    @courses = Course.all.limit(3)
    @recent_courses = Course.all.limit(3).order(created_at: :desc)
  end
  def privacy_policy
  end
end
