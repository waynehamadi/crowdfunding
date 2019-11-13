class ContributionsController < ApplicationController
  def create
    @contribution = Contribution.new(contribution_params)
    transaction = CreateContribution.new.call(contribution: @contribution, project_id: params[:project_id], user: current_user)

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
