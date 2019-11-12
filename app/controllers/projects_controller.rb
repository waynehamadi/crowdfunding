class ProjectsController < ApplicationController
  def index
    @projects= Project.all.where(aasm_state: %w[upcoming ongoing success])
  end
end
