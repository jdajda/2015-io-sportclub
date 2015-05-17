class CourseDaysController < ApplicationController
  before_action :set_course
  before_action :set_course_event
  before_action :set_course_day, only: [:show, :update, :destroy]

  # GET /course_days
  # GET /course_days.json
  def index
    #@course = Course.find(params[:course_id])
    @course_days = Course.find(params[:course_id]).course_days
  end

  # GET /course_days/1
  # GET /course_days/1.json
  def show
  end

  # GET /course_days/new
  def new
    @course_day = CourseDay.new
    @course = Course.find(params[:course_id])
  end

  # GET /course_days/1/edit
  def edit
    @course_day = CourseDay.find(params[:id])
    @course = Course.find(params[:course_id])
  end

  # POST /course_days
  # POST /course_days.json
  def create
    @course_day = CourseDay.new(course_day_params)

    respond_to do |format|
      if @course_day.save
        format.html { redirect_to course_course_event_path(@course, @course_event), notice: 'Course day was successfully created.' }
        format.json { render :show, status: :created, location: @course_day }
      else
        format.html { render :new }
        format.json { render json: @course_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_days/1
  # PATCH/PUT /course_days/1.json
  def update
    respond_to do |format|
      if @course_day.update(course_day_params)
        format.html { redirect_to @course_day, notice: 'Course day was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_day }
      else
        format.html { render :edit }
        format.json { render json: @course_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_days/1
  # DELETE /course_days/1.json
  def destroy
    course = @course_day.course
    @course_day.destroy
    respond_to do |format|
      format.html { redirect_to course, notice: 'Course day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_day
      @course_day = CourseDay.find(params[:id])
    end

    def set_course_event
      @course_event = CourseEvent.find(params[:course_event_id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_day_params
      x = params.require(:course_day).permit(:date, :time_begin, :time_end)
      x[:course_event_id] = @course_event.id
      x
    end
end
