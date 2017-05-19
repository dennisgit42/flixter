class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.enrollments.create(course: current_course)

    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source:  params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:  customer.id,
      amount:    @amount,
      description: 'Rails Stripe customer',
      currency:    'usd'
    )

  redirect_to course_path(current_course) 
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  private

  def current_course
    @course = Course.find(params[:course_id])
  end

end
