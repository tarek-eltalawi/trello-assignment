class SearchController < ApplicationController
  def show
  	project_name = params[:q]
    @projA = current_user.projects.where(name: project_name)
    @projB = current_user.projects.where(description: project_name)
    @projC = current_user.stories.where(name: project_name)
    if @projA.length == 0 and @projB.length == 0 and @projC.length == 0
      respond_to do |format|
          format.html { redirect_to projects_url, alert: 'Not found project' }
          format.json { head :no_content }
      end
    end
  end
end
