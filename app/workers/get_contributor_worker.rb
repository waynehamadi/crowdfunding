class GetContributorWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(project, user)
    transaction = CsvExport.new.call(pro: project, user: user)
    if transaction.failure?
      flash[:error] = transaction.failure[:error]
      redirect_to admin_project_path(project)
    else
      transaction.success[:filepath]
    end
  end
end
