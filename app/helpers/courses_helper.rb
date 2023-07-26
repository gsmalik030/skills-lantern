module CoursesHelper
  def enrollment_button(course)
    if course.user == current_user
      link_to "You created this course. See Analytics", course_path(course), class: "btn btn-sm btn-success"
    elsif course.enrollments.where(user: current_user).any?
      link_to "You are enrolled", course_path(course), class: "btn btn-sm btn-success"
    elsif course.price > 0
      link_to number_to_currency(course.price), new_course_enrollment_path(course), class: "btn btn-sm btn-warning"
    else
      link_to "Free", new_course_enrollment_path(course), class: "btn btn-sm btn-success"
    end
  end
end
