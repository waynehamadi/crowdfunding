
class CheckProject
  include Dry::Transaction
  step :validate

  private
  def validate(input)
    @project = input[:project]
    if @project.aasm_state == 'draft'
      @project.may_up? && @project.up! ? Success(input) : Failure(input)
    elsif @project.aasm_state == 'upcoming'
      @project.may_on? && @project.on! ? Success(input) : Failure(input)
    else
      Failure(input)
    end
  end
end
