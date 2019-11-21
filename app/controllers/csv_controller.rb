class CsvController < ApplicationController
  before_action :fetch_project, only: :download

  def download
    filepath = GetContributorWorker.new.perform(@project_id, current_admin_user.email)
      respond_to do |format|
        format.csv { send_data File.read(filepath) }
      end
  end

  private

  def fetch_project
    @project_id = params[:project]
  end
end

