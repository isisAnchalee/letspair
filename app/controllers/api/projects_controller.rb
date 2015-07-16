module Api
  class ProjectsController < ApiController
    # before_action :require_signed_in!

    def index
      @projects = Project.all.includes(:author)
      render :index
    end

    def new
      @project = Project.new
      render :new
    end

    def create
      @project = Project.new(project_params)
      @project.user_id = current_user.id
      @project.save!
      redirect_to root_url
    end

    def update
      @project = Project.find(params[:id])
      if @project.update_attributes(project_params)
        render :show
      else
        render json: { error: @project.errors.full_messages }
      end
    end

    def show
      @project = Project.find(params[:id])
      render :show
    end

    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      render json: @project
    end

    private

    def project_params
      params.require(:project).permit(:title, :description, :complexity, :price)
    end
  end
end