class TagsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @project.tags.create(params)
  end

  def show
    @tag = Tag.find(params[:id])
    @projects = @tag.projects
  end
end
