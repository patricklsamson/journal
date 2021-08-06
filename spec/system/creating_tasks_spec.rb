require 'rails_helper'

RSpec.describe 'CreatingTasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:click_create_task) { find('input[type="submit"]').click }

  let(:date_today) { Date.today }

  let(:category_id) { Category.find_by(title: 'Category Title').id }

  let(:task) { Task.find_by(details: 'Task Details') }
  let(:task_details) { task.details }
  let(:task_priority) { task.priority }
  let(:task_count) { Task.count }

  before :each do
    visit root_path
    click_new_category

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category
  end

  context 'when all form fields are filled up and submitted' do
    before :each do
      fill_in 'Details', with: 'Task Details'
      fill_in 'task[priority]', with: date_today
      click_create_task
    end

    it 'redirects to same page' do
      expect(page).to have_current_path(category_path(category_id))
    end

    it 'renders page with submitted inputs' do
      expect(page).to have_content('Task Details')
      expect(page).to have_content(date_today)
    end

    it 'creates a task' do
      expect(task_details).to eq('Task Details')
      expect(task_priority).to eq(date_today)
      expect(task_count).to eq 1
    end
  end

  context 'when all form fields are not filled up and submitted' do
    before :each do
      click_create_task
    end

    it 'redirects to same page' do
      expect(page).to have_current_path(category_path(category_id))
    end

    it 'does not create a task' do
      expect(task_count).to eq 0
      expect(task).to eq nil
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
