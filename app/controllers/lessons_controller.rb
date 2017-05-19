class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_enrolled?

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def user_enrolled?
    user_enrolled = false;
    current_lesson.section.course.enrollments.each do |enrollment|
      if enrollment.user == current_user
        user_enrolled = true
      end
    end
    if user_enrolled == false
      current_course = current_lesson.section.course
      redirect_to course_path(current_course), alert: "You must be enrolled in this course before you can view the lesson."
    end
  end

end
