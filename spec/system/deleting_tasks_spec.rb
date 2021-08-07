require 'rails_helper'

RSpec.describe 'DeletingTasks', type: :system do
  before do
    driven_by(:rack_test)

    category_create
    task_create

    visit category_path(category_id)
  end

  let(:date_today) { Date.today }

  let(:category_create) { Category.create(title: 'Category Title', details: 'Category Details') }
  let(:category_id) { Category.find_by(title: 'Category Title').id }

  let(:task_create) { Task.create(details: 'Task Details', priority: date_today, category_id: category_id) }
  let(:task_id) { Task.find_by(details: 'Task Details').id }
  let(:task_count) { Task.count }
  let(:task_deleted) { Task.find_by(details: 'Task Details') }

  let(:click_destroy_task) { find("a[href='/categories/#{category_id}/tasks/#{task_id}']").click }

  context 'when task was created within its category' do
    it 'redirects to same page' do
      expect(page).to have_current_path(category_path(category_id))
    end
  end

  context 'with that task can be deleted' do
    it 'deletes the task' do
      click_destroy_task

      expect(task_count).to eq 0
      expect(task_deleted).to eq nil
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
