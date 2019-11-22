class ContributionsController < ApplicationController

  def show
    @contribution = Contribution.find(params[:id])
    respond_to do |format|
      format.pdf { render pdf:  "contribution#{@contribution.id}" }
    end
  end
  def create
    @contribution = current_user.contributions.new(contribution_params)
    @project = Project.find_by_id(params[:project_id])
    @contribution.project = @project
    transaction = CreateContribution.new.call(contribution: @contribution)

    if transaction.success?
      redirect_to transaction.success[:redirect]
    else
      flash[:error] = transaction.failure[:error]
      redirect_to project_path(@project)
    end
  end

  def contribution_params
    params.require(:contribution).permit(:amount_in_cents, :counterpart)
  end
end
#
