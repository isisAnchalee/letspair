class ProjectsController < ApplicationController

	def index
		@project = Project.all.includes(:user)
		render :index
	end

	private

  def photo_params
    params.require(:project).permit(:title, :description)
  end
end
