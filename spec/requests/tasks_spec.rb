require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:date_today) { Date.today }
  let(:date_tomorrow) { date_today + 1 }

  let(:category_attributes) do
    {
      title: 'Category Title',
      details: 'Category Details'
    }
  end

  let(:category_create) { Category.create(category_attributes) }
  let(:category_id) { Category.find_by(title: 'Category Title').id }

  let(:valid_attributes) do
    {
      details: 'Task Details',
      priority: date_today,
      category_id: category_id
    }
  end

  let(:invalid_attributes) do
    {
      details: nil,
      priority: nil,
      category_id: nil
    }
  end

  let(:new_attributes) do
    {
      details: 'Task Details Edited',
      priority: date_tomorrow,
      category_id: category_id
    }
  end

  subject { Task.create(valid_attributes) }
  let(:task_invalid) { Task.create(invalid_attributes) }
  let(:task_count) { Task.count }

  before :each do
    category_create
  end

  describe 'GET /edit' do
    it 'responds sucessfully' do
      get edit_category_task_path(category_id, subject)
      expect(response).to be_successful
    end

    # pending "add some examples (or delete) #{__FILE__}"
  end

  describe 'POST /create' do
    before :each do
      post categories_path(category_id), params: { category: category_attributes }
    end

    context 'when valid' do
      before :each do
        post category_tasks_path(category_id, subject), params: { task: valid_attributes }
      end

      it 'creates a task' do
        expect(task_count).to eq 1
      end

      it 'redirects to its category' do
        expect(response).to redirect_to(category_path(category_id))
      end
    end

    context 'when invalid' do
      before :each do
        post category_tasks_path(category_id, task_invalid), params: { task: invalid_attributes }
      end

      it 'does not create a task' do
        expect(task_count).to eq 0
      end

      it 'redirects to its category' do
        expect(response).to redirect_to(category_path(category_id))
      end
    end
  end

  describe 'PATCH /update' do
    before :each do
      patch category_path(category_id), params: { category: category_attributes }
    end

    context 'when valid' do
      it 'redirects to itself' do
        patch category_task_path(category_id, subject), params: { task: new_attributes }
        expect(response).to redirect_to(category_path(category_id))
      end
    end

    context 'when invalid' do
      it 'responds successfully' do
        patch category_task_path(category_id, subject), params: { task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'redirects to root path' do
      delete category_task_path(category_id, subject)
      expect(task_count).to eq 0
      expect(response).to redirect_to(category_path(category_id))
    end
  end
end
