class CsvController < ApplicationController

  def download
    filepath = GetContributorsWorker.new.perform(params[:project])
      respond_to do |format|
        format.csv { send_data File.read(filepath) }
      end
  end

  private

end

