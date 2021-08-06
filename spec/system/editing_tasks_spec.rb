require 'rails_helper'

RSpec.describe 'EditingTasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:click_create_task) { find('input[type="submit"]').click }
  let(:click_edit_task) { find("a[href='/categories/#{category_id}/tasks/#{task_id}/edit']").click }
  let(:click_update_task) { find('input[type="submit"]').click }

  let(:date_today) { Date.today }
  let(:date_tomorrow) { date_today + 1 }

  let(:category_id) { Category.find_by(title: 'Category Title').id }

  let(:task) { Task.find_by(details: 'Task Details') }
  let(:task_id) { task.id }
  let(:task_details) { task.details }
  let(:task_priority) { task.priority }
  let(:task_count) { Task.count }

  let(:task_edited) { Task.find_by(details: 'Task Details Edited') }
  let(:task_edited_details) { task_edited.details }
  let(:task_edited_priority) { task_edited.priority }

  before :each do
    visit root_path
    click_new_category

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    fill_in 'Details', with: 'Task Details'
    fill_in 'task[priority]', with: date_today
    click_create_task

    click_edit_task
  end

  it 'redirects to form' do
    expect(page).to have_current_path(edit_category_task_path(category_id, task_id))
  end

  context 'when all form fields are filled up with new inputs and submitted' do
    before :each do
      fill_in 'Details', with: 'Task Details Edited'
      fill_in 'task[priority]', with: date_tomorrow
      click_update_task
    end

    it 'redirects to its category' do
      expect(page).to have_current_path(category_path(category_id))
    end

    it 'renders page with submitted inputs' do
      expect(page).to have_content('Task Details Edited')
      expect(page).to have_content(date_tomorrow)
    end

    it 'edits the task' do
      expect(task_count).to eq 1
      expect(task_edited_details).to eq('Task Details Edited')
      expect(task_edited_priority).to eq(date_tomorrow)
    end
  end

  context 'when all form fields are filled up with blank inputs and submitted' do
    before :each do
      fill_in 'Details', with: ''
      fill_in 'task[priority]', with: ''
      click_update_task
    end

    it 'redirects to same page' do
      expect(page).to have_current_path(category_task_path(category_id, task_id))
    end

    it 'raises errors' do
      expect(page).to have_content('blank')
      expect(page).to have_content('minimum')
    end

    it 'does not edit the task' do
      expect(task_count).to eq 1
      expect(task_details).to eq('Task Details')
      expect(task_priority).to eq(date_today)
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
