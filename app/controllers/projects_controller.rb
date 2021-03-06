class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_user]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_project

  #POST  /projects

  def add_user
    user_name = params[:q]
    @user = User.find_by_email user_name
    if @user
      if @user.projects.find_by_id(@project.id)
        respond_to do |format|
          format.html { redirect_to @project, notice: 'User Already added' }
          format.json { head :no_content }
        end
      else
        @user.projects << @project
        respond_to do |format|
          format.html { redirect_to @project, notice: 'User successfully added' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to @project, alert: 'Not found user' }
          format.json { head :no_content }
      end
    end
  end
  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects.all.paginate(:page => params[:page], :per_page => 4)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    unless @project.admin == current_user.id
      respond_to do |format|
          format.html { redirect_to projects_url, alert: 'Unspecified Action' }
          format.json { head :no_content }
      end
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.admin = current_user.id
    @project.users << current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    if(@project.admin == current_user.id)
      @project.destroy
      respond_to do |format|
        format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      current_user.stories.delete(@project.stories)
      current_user.projects.delete(@project)
        respond_to do |format|
          format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
          format.json { head :no_content }
        end
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :image_url, :avatar)
    end
  private
  def invalid_project
    logger.error "Attempt to access invalid project #{params[:id]}"
    redirect_to projects_url, alert: 'Invalid project'
  end
end
