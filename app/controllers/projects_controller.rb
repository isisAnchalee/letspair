class ProjectsController < ApplicationController

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

    if @project.save!
      flash[:success] = "New Project Created!"
      redirect_to @project
    else
      flash.now[:errors] = @project.errors.full_messages
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    render :show
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :complexity)
  end
end
