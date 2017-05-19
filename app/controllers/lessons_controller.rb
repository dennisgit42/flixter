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
    current_course = current_lesson.section.course
    enrolled = Enrollment.find_by(user: current_user, course: current_course)
    if enrolled.nil?
      redirect_to course_path(current_course), alert: "You must be enrolled in the course before viewing its lessons."
    end
  end

end
