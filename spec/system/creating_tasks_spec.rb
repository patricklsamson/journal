require 'rails_helper'

RSpec.describe 'CreatingTasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:category_id) { Category.find_by(title: 'Category Title').id }

  before :each do
    visit root_path
    click_new_category

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category
  end

  let(:click_create_task) { find('input[type="submit"]').click }
  let(:task_count) { Task.count }
  let(:task) { Task.find_by(details: 'Task Details') }
  let(:task_details) { task.details }

  context 'when valid' do
    it 'creates a task' do
      fill_in 'Details', with: 'Task Details'
      click_create_task

      expect(page).to have_current_path(category_path(category_id))
      expect(page).to have_content('Task Details')

      expect(task_count).to eq 1
      expect(task_details).to eq('Task Details')
    end
  end

  context 'when invalid' do
    it 'does not create a task' do
      click_create_task

      expect(page).to have_current_path(category_path(category_id))

      expect(task_count).to eq 0
      expect(task).to eq nil
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
