class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy, :todo, :doing, :done]


  def todo
    @project = current_user.projects.find(params[:project_id])
    @story.state = "to do"
    @story.save
    respond_to do |format|
      format.js 
    end
  end

  def doing 
    @project = current_user.projects.find(params[:project_id])
    # @project = current_user.projects.find(params[:id])
    @story.state = "doing"
    @story.save
    respond_to do |format|
      format.js 
    end
  end

  def done
    @project = current_user.projects.find(params[:project_id])
    @story.state = "done"
    @story.save
    respond_to do |format|
      format.js 
    end
  end

  def add_user
    user_name = params[:q]
    @user = User.find_by_email user_name
    @sto = Story.find_by_id params[:stn]
    if @user
      if @user.stories.find_by_id(params[:stn])
        respond_to do |format|
          format.html { redirect_to @sto.project, notice: 'User Already added' }
          format.json { head :no_content }
        end
      elsif @user.projects.find_by_id(@sto.project.id)
        @user.stories << @sto
        respond_to do |format|
          format.html { redirect_to @sto.project, notice: 'User successfully added' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to @sto.project, notice: 'User is not in the project' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to @sto.project, alert: 'Not found user' }
          format.json { head :no_content }
      end
    end
  end
  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
  end

  # GET /stories/new
  def new
    @project = Project.find params[:project_id]
    unless @project.admin == current_user.id
      respond_to do |format|
          format.html { redirect_to projects_url, alert: 'Unspecified Action' }
          format.json { head :no_content }
      end
    else
      @story = Story.new
      @story.project_id = params[:project_id] if current_user.projects.where(id: params[:project_id])
    end
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.project_id = params[:project_id] if current_user.projects.where(id: params[:project_id])
    @story.state = "to do"
    respond_to do |format|
      if @story.save
        format.html { redirect_to @story.project, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story.project, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to project_stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:name, :description, :state, :project_id)
    end
end
