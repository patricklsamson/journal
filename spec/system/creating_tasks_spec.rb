require 'rails_helper'

RSpec.describe 'CreatingTasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:date_today) { Date.today }
  let(:date_tomorrow) { date_today + 1 }

  let(:category_create) { Category.create(title: 'Category Title', details: 'Category Details') }
  let(:category_id) { Category.find_by(title: 'Category Title').id }

  let(:task) { Task.find_by(details: 'Task Details') }
  let(:task_details) { task.details }
  let(:task_priority) { task.priority }
  let(:task_count) { Task.count }

  let(:click_create_task) { find('input[type="submit"]').click }

  before :each do
    category_create
    visit category_path(category_id)
  end

  context 'when a category was created it redirects to itself and a task can be created' do
    it 'expects form inside' do
      expect(page).to have_current_path(category_path(category_id))
    end
  end

  context 'when all form fields were filled up and submitted' do
    before :each do
      fill_in 'Details', with: 'Task Details'
    end

    context 'with priority date was date today' do
      before :each do
        fill_in 'task[priority]', with: date_today
        click_create_task
      end

      it 'creates a task' do
        expect(task_details).to eq('Task Details')
        expect(task_priority).to eq(date_today)
        expect(task_count).to eq 1
      end

      it 'redirects to same page' do
        expect(page).to have_current_path(category_path(category_id))
      end

      context 'when navigating under "Tasks for Today"' do
        it 'shows created task' do
          within('#today-wrap') { expect(page).to have_content('Task Details') }
        end
      end
    end

    context 'with priority date was date tomorrow' do
      before :each do
        fill_in 'task[priority]', with: date_tomorrow
        click_create_task
      end

      it 'creates a task' do
        expect(task_details).to eq('Task Details')
        expect(task_priority).to eq(date_tomorrow)
        expect(task_count).to eq 1
      end

      it 'redirects to same page' do
        expect(page).to have_current_path(category_path(category_id))
      end

      context 'when navigating under "Future Tasks"' do
        it 'shows created task' do
          within('#future-wrap') { expect(page).to have_content('Task Details') }
        end
      end
    end
  end

  context 'when all form fields were not filled up and submitted' do
    before :each do
      click_create_task
    end

    it 'does not create a task' do
      expect(task_count).to eq 0
      expect(task).to eq nil
    end

    it 'redirects to same page' do
      expect(page).to have_current_path(category_path(category_id))
    end

    context 'with details blank' do
      it 'renders page without changes' do
        expect(page).to_not have_content('Task Details')
      end
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
