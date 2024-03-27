# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find params[:id]
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find params[:id]
  end

  def create
    @task = Task.new(task_params)
    redirect_to(@task, notice: 'Task was successfully created.') if @task.save!
    render(:new, status: :unprocessable_entity) unless @task.persisted?
  end

  def update
    @task = Task.find(params[:id])
    redirect_to(@task, notice: 'Task was successfully updated.') if @task.update!(task_params)
    render(:edit, status: :unprocessable_entity) unless @task.valid?
  end

  def destroy
    @task = Task.find params[:id]

    @task.destroy

    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :status, :creator, :performer, :completed)
  end
end
