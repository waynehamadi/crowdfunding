class GetContributorWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(project_id)
    transaction = CsvExport.new.call(project_id: project_id)
    if transaction.failure?
      flash[:error] = transaction.failure[:error]
      redirect_to admin_project_path(project)
    else
      transaction.success[:filepath]
    end
  end
end
