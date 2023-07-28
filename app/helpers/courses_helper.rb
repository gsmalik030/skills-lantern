module CoursesHelper
  def subscription_btn(course)
    if course.user == current_user
      link_to "You created this course. See Analytics", course_path(course), class: "btn btn-sm btn-success"
    elsif course.enrollments.where(user: current_user).any?
      link_to course_path(course), class: "btn btn-sm btn-success" do
        number_to_percentage(course.progress_in_percentage(current_user), precision: 0)
      end
    elsif course.price > 0
      link_to number_to_currency(course.price), new_course_enrollment_path(course), class: "btn btn-sm btn-warning"
    else
      link_to "Free", new_course_enrollment_path(course), class: "btn btn-sm btn-success"
    end
  end

  def review_btn(course)
    if current_user
      user=course.enrollments.where(user: current_user)
      if user.any?
        if user.where(rating: [0, nil, ""], review: [0, nil, ""]).any?
          link_to "Leave a Review", edit_enrollment_path(user.first), class: "btn btn-sm btn-outline-success"
        else
          "You already reviewed this course."
          
        end
      end
    end
  end
end
