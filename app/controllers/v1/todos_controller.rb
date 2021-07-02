# app/controllers/todos_controller.rb
module V1
  class TodosController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]

    # GET /todos
    def index
      # @todos = Todo.all
      # json_response(@todos)

      # get current user todos
      # @todos = current_user.todos
      @todos = current_user.todos.paginate(page: params[:page], per_page: 20)
      json_response(@todos)
    end

    # POST /todos
    def create
      # @todo = Todo.create!(todo_params)
      # json_response(@todo, :created)

      # create todos belonging to current user
      @todo = current_user.todos.create!(todo_params)
      json_response(@todo, :created)

    end

    # GET /todos/:id
    def show
      json_response(@todo)
    end

    # PUT /todos/:id
    def update
      @todo.update(todo_params)
      head :no_content
    end

    # DELETE /todos/:id
    def destroy
      @todo.destroy
      head :no_content
    end

    private

    # - new_jwt - remove `created_by` from list of permitted parameters
    def todo_params
      params.permit(:title)
    end

    def todo_params
      # whitelist params
      params.permit(:title, :created_by)
    end

    def set_todo
      @todo = Todo.find(params[:id])
    end

  end
end