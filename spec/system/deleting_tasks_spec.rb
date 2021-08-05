require 'rails_helper'

RSpec.describe 'DeletingTasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:click_create_task) { find('input[type="submit"]').click }
  let(:category_id) { Category.find_by(title: 'Category Title').id }
  let(:task_id) { Task.find_by(details: 'Task Details').id }
  let(:click_destroy_task) { find("a[href='/categories/#{category_id}/tasks/#{task_id}']").click }
  let(:task_count) { Task.count }
  let(:task) { Task.find_by(details: 'Task Details') }

  it 'deletes a task' do
    visit root_path
    click_new_category

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    fill_in 'Details', with: 'Task Details'
    click_create_task

    click_destroy_task
    expect(task_count).to eq 0
    expect(task).to eq nil
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
