class ProjectsController < ApplicationController
  def index
    @q = Project.all.where(aasm_state: %w[upcoming ongoing success]).ransack(params[:q])
    @projects = @q.result
  end

  def show
    @project = Project.find(params[:id])
    @contribution = Contribution.new
  end

  def bankwire
    @project = Project.find(params[:id])
    @contribution = Contribution.new
  end
end
