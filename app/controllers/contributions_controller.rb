class ContributionsController < ApplicationController
  def create
    @contribution = Contribution.new(contribution_params)
    @project = Project.find_by_id(params[:project_id])
    @contribution.project = @project
    @contribution.user = current_user
    if @contribution.save
       redirect_to project_path(@project), flash: {success: "Thanks for your contribution"}
      else
       redirect_to project_path(@project), flash: {error: @contribution.errors.full_messages}
    end

  end
   def contribution_params
    params.require(:contribution).permit(:amount_in_cents, :counterpart_id)
  end
end
