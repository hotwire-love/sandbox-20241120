class TasksController < ApplicationController
  before_action :set_task, only: %i[update]

  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, status: :see_other, notice: "Task was successfully created."
    else
      @tasks = Task.all
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @task.update!(task_done_params)
    redirect_to tasks_path, status: :see_other, notice: "Task was successfully updated."
  end

  private

    def set_task
      @task = Task.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.expect(task: [ :title, :done ])
    end

    def task_done_params
      params.expect(task: [ :done ])
    end
end
