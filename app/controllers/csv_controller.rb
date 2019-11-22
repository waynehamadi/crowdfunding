class CsvController < ApplicationController

  def download
    project_id = params[:project_id]
    transaction = GetContributorsWorker.new.perform(params[:project_id])
    if transaction.failure?
      flash[:error] = transaction.failure[:error]
      redirect_to admin_project_path(project_id)
    else
      file_path = transaction.success[:file_path]
      respond_to do |format|
        format.csv { send_data File.read(file_path) }
      end
      File.delete(file_path)
    end
  end
end

