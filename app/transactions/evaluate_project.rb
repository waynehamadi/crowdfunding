class EvaluateProject
  include Dry::Transaction
  step :validate

  def validate(input)
    @project = input[:project]
    if @project.may_failure?
      @project.failure!
      Success(input)
    elsif @project.may_success?
      @project.success!
      Success(input)
    else
      Failure(input)
    end
  end
end
