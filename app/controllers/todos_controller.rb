class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :toggle]
  
  def index
    @todos = Todo.all.order(created_at: :desc)
    @completed_todos = @todos.completed
    @incomplete_todos = @todos.incomplete
  end
  
  def new
    @todo = Todo.new
  end
  
  def create
    @todo = Todo.new(todo_params)
    
    if @todo.save
      redirect_to todos_path, notice: 'Todo was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: 'Todo was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @todo.destroy
    redirect_to todos_path, notice: 'Todo was successfully deleted.'
  end
  
  def toggle
    @todo.toggle_completion!
    redirect_to todos_path, notice: "Todo marked as #{@todo.completed ? 'completed' : 'incomplete'}."
  end
  
  private
  
  def set_todo
    @todo = Todo.find(params[:id])
  end
  
  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end
