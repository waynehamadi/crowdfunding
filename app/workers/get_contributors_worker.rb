class GetContributorsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(project_id)
    GetContributors.new.call(project_id: project_id)
  end
end
