class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_user]
  

  #POST  /projects
  def search
    project_name = params[:q]
    @proj = Project.find_by_name project_name
    if @proj
      respond_to do |format|
          format.html { redirect_to @proj, notice: 'Project Found' }
          format.json { head :no_content }
      end
    else
      respond_to do |format|
          format.html { redirect_to projects_url, notice: 'Not found project name' }
          format.json { head :no_content }
      end
    end
  end
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
          format.html { redirect_to @project, notice: 'Not found user' }
          format.json { head :no_content }
      end
    end
  end
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all.paginate(:page => params[:page], :per_page => 4)
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
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :image_url)
    end
end
