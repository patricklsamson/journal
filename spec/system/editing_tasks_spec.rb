require 'rails_helper'

RSpec.describe 'EditingTasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:date_today) { Date.today }
  let(:date_tomorrow) { date_today + 1 }

  let(:category_create) { Category.create(title: 'Category Title', details: 'Category Details') }
  let(:category_id) { Category.find_by(title: 'Category Title').id }

  let(:task_create) { Task.create(details: 'Task Details', priority: date_today, category_id: category_id) }
  let(:task) { Task.find_by(details: 'Task Details') }
  let(:task_id) { task.id }
  let(:task_details) { task.details }
  let(:task_priority) { task.priority }

  let(:task_edited) { Task.find_by(details: 'Task Details Edited') }
  let(:task_edited_details) { task_edited.details }
  let(:task_edited_priority) { task_edited.priority }

  let(:click_edit_task) { find("a[href='/categories/#{category_id}/tasks/#{task_id}/edit']").click }
  let(:click_update_task) { find('input[type="submit"]').click }

  before :each do
    category_create
    task_create

    visit category_path(category_id)
    click_edit_task
  end

  context 'when task was created within its category, with priority date was date today then it can be edited' do
    it 'goes to form' do
      expect(page).to have_current_path(edit_category_task_path(category_id, task_id))
    end
  end

  context 'when all form fields were filled up with new inputs and submitted with priority date was date tomorrow' do
    before :each do
      fill_in 'Details', with: 'Task Details Edited'
      fill_in 'task[priority]', with: date_tomorrow
      click_update_task
    end

    it 'updates task' do
      expect(task_edited_details).to eq('Task Details Edited')
      expect(task_edited_priority).to eq(date_tomorrow)
    end

    it 'redirects to its category' do
      expect(page).to have_current_path(category_path(category_id))
    end

    context 'when navigating under "Future Tasks"' do
      it 'shows updated task' do
        within('#future-wrap') { expect(page).to have_content('Task Details Edited') }
      end
    end
  end

  context 'when all form fields were filled up with blank inputs and submitted' do
    before :each do
      fill_in 'Details', with: ''
      fill_in 'task[priority]', with: ''
      click_update_task
    end

    it 'does not update task' do
      expect(task_details).to eq('Task Details')
      expect(task_priority).to eq(date_today)
    end

    it 'redirects back to form' do
      expect(page).to have_current_path(category_task_path(category_id, task_id))
    end

    context 'with details blank' do
      it 'raises an error' do
        expect(page).to have_content('blank')
      end
    end

    context 'with priority date blank and considered in the past' do
      it 'raises an error' do
        expect(page).to have_content('minimum')
      end
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
