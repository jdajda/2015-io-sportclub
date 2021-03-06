class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :sign]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # GET /courses/1/sign
  def sign
    respond_to do |format|

      if !logged_in?
        format.html { redirect_to new_session_path, notice: "You must log in" }
      else

        if signed?
          format.html { redirect_to course_path(@course), notice: "Already signed up" }
        else
          @userCourse = UserCourse.new(user: current_user, course: @course)

          if @userCourse.save
            format.html { redirect_to course_path(@course) }
          else
            format.html { redirect_to course_path(@course), notice: "Signing up failed" }
          end
        end
      end
    end

  end


  def signed?
    begin
      UserCourse.find_by(user: current_user, course: @course)
    rescue Mongoid::Errors::DocumentNotFound
      return false
    end

    return true
  end

  helper_method :signed?


  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:name, :description, :photo)
  end
end
