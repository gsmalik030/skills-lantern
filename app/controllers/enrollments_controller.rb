class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]
  before_action :set_course, only: %i[ create new ]

  # GET /enrollments or /enrollments.json
  def index
    @ransack_path = enrollments_path
    @q = Enrollment.ransack(params[:q])
    @pagy, @enrollments = pagy(@q.result.includes(:user, :course))

    authorize @enrollments
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
    authorize @enrollment
  end

  def students_enrolled
    @ransack_path = students_enrolled_enrollments_path
    @q = Enrollment.joins(:course).where(courses: {user: current_user}).ransack(params[:q])
    @pagy, @enrollments = pagy(@q.result.includes(:user))
    render 'index'
  end

  def create
    if @course.price > 0
      flash[:alert] = "You can't enroll paid courses yet."
      redirect_to course_path(@course)
    else
      @enrollment = current_user.buy_course(@course)
      redirect_to new_course_enrollment_path(@course), notice: "You have successfully enrolled to this course."
    end
  end

  def update
    authorize @enrollment
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully updated." }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @enrollment
    @enrollment.destroy

    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: "Enrollment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end
    def set_enrollment
      @enrollment = Enrollment.friendly.find(params[:id])
    end

    def enrollment_params
      params.require(:enrollment).permit(:rating, :review)
    end
end
