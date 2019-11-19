class ProjectsController < ApplicationController
  def index
    @query = Project.all.where(aasm_state: %w[upcoming ongoing success]).ransack(params[:q])
    @projects= @query.result
  end
  def show
    @project = Project.find(params[:id])
    @contribution = Contribution.new
  end
end
