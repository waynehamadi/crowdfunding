class ContributionsController < ApplicationController

  def show

    @contribution = Contribution.find(params[:id])
    respond_to do |format|
      format.pdf { render pdf:  "contribution#{@contribution.id}" }
    end
  end

  def create

    toto = params[:project_id]
    @contribution = current_user.contributions.new(amount_in_cents: contribution_params["amount_in_cents"], counterpart_id:contribution_params["counterpart_id"])
    @project = Project.find_by_id(params[:project_id])
    @contribution.project = @project
    toto = contribution_params["bankwire"]
    if contribution_params["bankwire"]
      transaction = CreateBankwireContribution.new.call(contribution: @contribution)
    else
      transaction = CreateCardContribution.new.call(contribution: @contribution)
    end

    if transaction.success?
      redirect_to transaction.success[:redirect]
    else
      flash[:error] = transaction.failure[:error]
      redirect_to project_path(@project)
    end
  end

  def contribution_params
    params.require(:contribution).permit(:amount_in_cents, :counterpart_id, :bankwire)
  end
end
