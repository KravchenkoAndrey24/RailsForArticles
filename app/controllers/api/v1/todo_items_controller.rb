class Api::V1::TodoItemsController < ApplicationController

  def index
    @todo_items = Todolist.where(user_id: current_user.id)
    render json: @todo_items

  end

  def show
      respond_to do |format|
        format.json { render :show }
      end
  end

  def create
    new_article = Todolist.new(todo_item_params)
    new_article.save
    render json: new_article
  end

  def update
    new_todo_item = Todolist.find_by(id: params[:id])
    if todo_item_params[:edit_title]
      new_todo_item.title = todo_item_params[:edit_title]
    end
    if todo_item_params[:edit_complete].to_s == 'true'
      new_todo_item.complete = todo_item_params[:edit_complete]
    end
    if todo_item_params[:edit_complete].to_s == 'false'
      new_todo_item.complete = todo_item_params[:edit_complete]
    end
    new_todo_item.save

  end

  def destroy
    Todolist.find_by(id: params[:id]).destroy
    render json: {
      message: 'todo item deleted'
    }
  end

  private

  def set_todo_item
    @todo_item = TodoItem.find(params[:id])
  end

  def authorized?
    @todo_item.user == current_user
  end

  def handle_unauthorized
    unless authorized?
      respond_to do |format|
        format.json { render :unauthorized, status: 401 }
      end
    end
  end

  def todo_item_params
    params.require(:todo_item).permit(:title, :complete, :user_id,  :edit_complete, :edit_title)
  end
end

