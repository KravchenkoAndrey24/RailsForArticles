require "rails_helper"
RSpec.describe "Todolist", :type => :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @sign_in_url = '/api/v1/auth/sign_in'
    @sign_out_url = '/api/v1/auth/sign_out'
    @login_params = {
      email: @user.email,
      password: @user.password
    }
    @todo_params = {
      title: 'test',
      complete: false,
      user_id: @user.id
    }
    @todo_list = Todolist.new(@todo_params)
    @todo_list.save

    @edit_todo_params = {
      title: 'title after edit',
      complete: true
    }
  end
  describe 'TODOLIST CRUD' do
    before do
      #login @user created in the before block in outer describe block
      post @sign_in_url, params: @login_params, as: :json
      @headers = {
        'uid' => response.headers['uid'],
        'client' => response.headers['client'],
        'access-token' => response.headers['access-token']
      }
    end
    describe 'GET /api/v1/todo_items' do
      it 'get tasks with headers returns status 200' do
        get '/api/v1/todo_items', headers: @headers
        expect(response).to have_http_status(200)
      end
      it 'get tasks without headers returns status 401' do
        get '/api/v1/todo_items'
        expect(response).to have_http_status(401)
      end
    end

    describe 'POST /api/v1/todo_items' do
      it 'create new task with headers returns status 200' do
        post '/api/v1/todo_items', params: @todo_params, headers: @headers
        expect(response).to have_http_status(200)
      end
      it 'create new task without headers returns status 401' do
        post '/api/v1/todo_items', params: @todo_params
        expect(response).to have_http_status(401)
      end
    end

    describe 'PUT /api/v1/todo_items/id' do
      it 'update task with headers returns status 200' do
        put "/api/v1/todo_items/#{@todo_list.id}", headers: @headers, params: @edit_todo_params
        expect(response).to have_http_status(200)
      end
      it 'update task without headers returns status 401' do
        put "/api/v1/todo_items/#{@todo_list.id}", params: @edit_todo_params
        expect(response).to have_http_status(401)
      end
    end
    describe 'DELETE /api/v1/todo_items/id' do
      it 'delete task with headers returns status 200' do
        delete "/api/v1/todo_items/#{@todo_list.id}", headers: @headers, params: @edit_todo_params
        expect(response).to have_http_status(200)
      end
      it 'delete task without headers returns status 401' do
        delete "/api/v1/todo_items/#{@todo_list.id}", params: @edit_todo_params
        expect(response).to have_http_status(401)
      end
    end
  end
end