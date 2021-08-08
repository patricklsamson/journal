require 'rails_helper'

RSpec.describe 'CreatingTasks', type: :system do
  before do
    driven_by(:rack_test)
    category
    visit category_path(category)
  end

  let(:category) { Category.create(title: 'Category Title', details: 'Category Details') }

  describe Task do
    subject { described_class.find_by(details: 'Task Details') }
    let(:subject_count) { Task.count }
    let(:click_create) { find('input[type="submit"]').click }

    context 'when a category was created it redirects to itself and a task can be created' do
      it 'expects form inside' do
        expect(page).to have_current_path(category_path(category))
      end
    end

    context 'when all form fields were filled up and submitted' do
      let(:date_today) { Date.today }
      let(:date_tomorrow) { date_today + 1 }

      let(:subject_details) { subject.details }
      let(:subject_priority) { subject.priority }

      before do
        fill_in 'Details', with: 'Task Details'
      end

      context 'with priority date was date today' do
        before do
          fill_in 'task[priority]', with: date_today
          click_create
        end

        it 'creates a task' do
          expect(subject_details).to eq('Task Details')
          expect(subject_priority).to eq(date_today)
          expect(subject_count).to eq 1
        end

        it 'redirects to same page' do
          expect(page).to have_current_path(category_path(category))
        end

        context 'when navigating under "Tasks for Today"' do
          it 'shows created task' do
            within('#today-wrap') { expect(page).to have_content('Task Details') }
          end
        end
      end

      context 'with priority date was date tomorrow' do
        before do
          fill_in 'task[priority]', with: date_tomorrow
          click_create
        end

        it 'creates a task' do
          expect(subject_details).to eq('Task Details')
          expect(subject_priority).to eq(date_tomorrow)
          expect(subject_count).to eq 1
        end

        it 'redirects to same page' do
          expect(page).to have_current_path(category_path(category))
        end

        context 'when navigating under "Future Tasks"' do
          it 'shows created task' do
            within('#future-wrap') { expect(page).to have_content('Task Details') }
          end
        end
      end
    end

    context 'when all form fields were not filled up and submitted' do
      before do
        click_create
      end

      it 'does not create a task' do
        expect(subject).to eq nil
        expect(subject_count).to eq 0
      end

      it 'redirects to same page' do
        expect(page).to have_current_path(category_path(category))
      end

      context 'with details blank' do
        it 'renders page without changes' do
          within('#overdue-wrap') { expect(page).to have_content('Nothing else here yet.') }
          within('#today-wrap') { expect(page).to have_content('Nothing else here yet.') }
          within('#future-wrap') { expect(page).to have_content('Nothing else here yet.') }
        end
      end
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
