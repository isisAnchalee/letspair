class ProjectsController < ApplicationController

	def index
		@projects = Project.all.includes(:user)
		render :index
	end

	private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
