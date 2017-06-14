require 'rails_helper'

RSpec.describe ListsController, type: :controller do

  describe 'GET #index' do
    it 'returns http sucess' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the lists instance variable' do
      get :index
      expect(assigns(:lists).length).to eq(0)
    end

    it 'renders the index templates' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'set the correct lists in the instance variable' do
      list = List.create(task: 'Do laundry')
      get :index
      expect(assigns(:lists).length).to eq(1)
      expect(assigns(:lists).first).to eq(list)
    end
  end

  describe 'GET #show' do
    it 'returns http sucess' do
      list = List.create(task: 'Do laundry')
      get :show, params: {id: list.id}
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      list = List.create(task: 'Do laundry')
      get :show, params: {id: list.id}
      expect(response).to render_template(:show)
    end

    it 'sets the list variable' do
      list = List.create(task: 'Do laundry')
      get :show, params: {id: list.id}
      expect(assigns(:list)).to eq(list)
    end

  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'sets the list instance variable' do
      get :new
      expect(assigns(:list)).to be_a_new(List)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      list = List.create(task: 'Do laundry')
      get :edit, params: {id: list.id}
      expect(response).to have_http_status(:success)
    end

    it 'renders the edit template' do
      list = List.create(task: 'Do laundry')
      get :edit, params: {id: list.id}
      expect(response).to render_template(:edit)
    end

    it 'sets the list instance variable' do
      list = List.create(task: 'Do laundry')
      get :edit, params: {id: list.id}
      expect(assigns(:list)).to eq(list)
    end
  end

  describe 'POST #create' do
    it 'returns http redirect' do
      post :create, params: {list: {task: 'new task'}}
      expect(response).to have_http_status(:redirect)
    end

    it 'sets the list instance variable' do
      task = 'new task'
      post :create, params: {list:{task: task}}
      expect(assigns(:list).task).to eq(task)
    end

    it 'redirects to the list path on a successful list create' do
      post :create, params: {list:{task: 'new task'}}
      list = assigns(:list)
      expect(response).to redirect_to(list_path(list))
    end

    it 'renders the new template on unsuccessful list create' do
      post :create, params: {list:{task: ''}}
      expect(List.count).to eq(0)
      expect(response).to render_template(:new)
    end

    it 'saves the list to the database' do
      task = 'new task'
      post :create, params: { list: {task:task } }
      expect(List.count).to eq(1)
      expect(assigns(:list).task).to eq(task)
    end
  end

  describe 'PUT #update' do
    it 'returns http redirect on success' do
      list = List.create(task:'do laundry')
      put :update, params: {id: list.id, list:{task:'mow lawn'}}
      expect(response).to have_http_status(:redirect)
    end

    it 'sets the list instance variable' do
      list = List.create(task: 'do laundry')
      put :update, params: {id: list.id, list:{taks:'mow lawn'}}
      expect(assigns(:list).task).to eq(list.reload.task)
    end

    it 'redirects to the list path on a succesful update' do
      list = List.create(task: 'do laundry')
      put :update, params: {id: list.id, list:{taks:'mow lawn'}}
      expect(response).to redirect_to(list_path(list))
    end

    it 'renders the edit template on an unsuccessful update' do
      task = "do laundry"
      list = List.create(task: task)
      put :update, params: {id: list.id, list:{task:''}}
      expect(response).to render_template(:edit)
      expect(list.reload.task).to eq(task)
    end

    it 'updates the list in the database' do
      task = 'do laundry'
      list = List.create(task: task)
      put :update, params: {id: list.id, list:{task:''}}
      expect(list.reload.task).to eq(task)
    end
  end

  describe 'DELETE #destroy' do

    it 'returns http redirect' do
      list = List.create(task: 'walk the dog')
      delete :destroy, params: {id: list.id}
      expect(response).to have_http_status(:redirect)
    end

    it 'sets the list instance variable' do
      list = List.create(task: 'walk the dog')
      delete :destroy, params: {id: list.id}
      expect(assigns(:list)).to eq(list)
    end

    it 'deletes the list from the database' do
      list = List.create(task: 'walk the dog')
      expect(List.count).to eq(1)
      expect{delete :destroy, params: {id: list.id}}.to change{List.count}.from(1).to(0)
    end

    it 'redirects to the list index path on a successful destroy' do
      list = List.create(task: 'walk the dog')
      delete :destroy, params: {id: list.id}
      expect(response).to redirect_to(lists_path)
    end

  end


end
