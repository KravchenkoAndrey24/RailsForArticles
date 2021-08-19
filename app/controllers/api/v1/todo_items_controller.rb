class Api::V1::TodoItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @todo_items = Todolist.where(user_id: current_user[:id]).order(:id).reverse
    render json: @todo_items
  end

  def create
    new_todo_item = Todolist.new(user_id: current_user[:id],
                                 title: params[:title],
                                 complete: params[:complete])
    new_todo_item.save
    render json: new_todo_item
  end

  def update
    updated_todo_item = Todolist.find_by(id: params[:id])
    updated_todo_item.update(title: params[:edit_title], complete: params[:edit_complete])
    updated_todo_item.save
    render json: {
      message: 'changed  successfully'
    }
  end

  def destroy
    if Todolist.find_by(id: params[:id]).destroy
      render json: {
        message: 'deleted successfully'
      }
    end
  end

  private

  def handle_unauthorized
    unless authorized?
      respond_to do |format|
        format.json { render :unauthorized, status: 401 }
      end
    end
  end

  def todo_item_params
    params.require(:todo_item).permit(:title, :complete, :edit_complete, :edit_title)
  end
end

