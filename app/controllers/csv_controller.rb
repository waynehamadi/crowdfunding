class CsvController < ApplicationController
  before_action :fetch_project, only: :download

  def download
    filepath = GetContributorsWorker.new.perform(params[:project])
      respond_to do |format|
        format.csv { send_data File.read(filepath) }
      end
  end

  private

  def fetch_project
    @project_id = params[:project]
  end
end

