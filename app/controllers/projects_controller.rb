class ProjectsController < ApplicationController
  def index
      @project_items = Project.all
  end
  def create
      Project.create(:project_item => params[:project_title])
      redirect_to :action => 'index'
  end
end
