require 'rails_helper'

RSpec.describe 'EditingTasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:click_create_task) { find('input[type="submit"]').click }
  let(:category_id) { Category.find_by(title: 'Category Title').id }
  let(:task) { Task.find_by(details: 'Task Details') }
  let(:task_id) { task.id }
  let(:click_edit_task) { find("a[href='/categories/#{category_id}/tasks/#{task_id}/edit']").click }

  before :each do
    visit root_path
    click_new_category

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    fill_in 'Details', with: 'Task Details'
    click_create_task

    click_edit_task

    expect(page).to have_current_path(edit_category_task_path(category_id, task_id))
  end

  let(:click_update_task) { find('input[type="submit"]').click }
  let(:task_count) { Task.count }
  let(:task_edited) { Task.find_by(details: 'Task Details Edited') }
  let(:task_edited_details) { Task.find_by(details: 'Task Details Edited').details }
  let(:task_details) { task.details }

  context 'when valid' do
    it 'edits a task' do
      fill_in 'Details', with: 'Task Details Edited'
      click_update_task

      expect(page).to have_current_path(category_path(category_id))
      expect(page).to have_content('Task Details Edited')

      expect(task_count).to eq 1
      expect(task_edited_details).to eq('Task Details Edited')
    end
  end

  context 'when invalid' do
    before :each do
      fill_in 'Details', with: ''
      click_update_task

      expect(page).to have_current_path(category_task_path(category_id, task_id))
    end

    it 'raises an error' do
      expect(page).to have_content('blank')
      expect(page).to have_content('minimum')
    end

    it 'does not edit a task' do
      expect(task_count).to eq 1
      expect(task_details).to eq('Task Details')
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
