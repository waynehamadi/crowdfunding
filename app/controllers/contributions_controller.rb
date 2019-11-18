class ContributionsController < ApplicationController
  def create
    @contribution = current_user.contributions.new(contribution_params)
    @project = Project.find_by_id(params[:project_id])
    @contribution.project = @project
    @contribution.user = current_user
    transaction = CreateContribution.new.call(contribution: @contribution)

    if transaction.success?
      redirect_to transaction.success[:redirect]
    else
      flash[:error] = transaction.failure[:error]
      redirect_to project_path(transaction.failure[:project])
    end
  end
  def contribution_params
    params.require(:contribution).permit(:amount_in_cents, :counterpart_id)
  end
end
#
