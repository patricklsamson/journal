require 'rails_helper'

RSpec.describe 'CreatingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe Category do
    subject { described_class.find_by(title: 'Category Title') }
    let(:subject_count) { Category.count }

    let(:click_new) { find('a[href="/categories/new"]').click }
    let(:click_create) { find('input[type="submit"]').click }

    before do
      visit categories_path
      click_new
    end

    context 'when navigating in page of all categories then a category can be created' do
      it 'goes to form' do
        expect(page).to have_current_path(new_category_path)
      end
    end

    context 'when all form fields were filled up and submitted' do
      before do
        fill_in 'Title', with: 'Category Title'
        fill_in 'Details', with: 'Category Details'
        click_create
      end

      it 'creates a category' do
        expect(subject.title).to eq('Category Title')
        expect(subject.details).to eq('Category Details')
        expect(subject_count).to eq 1
      end

      it 'redirects to created category' do
        expect(page).to have_current_path(category_path(subject))
      end

      it 'renders page with submitted inputs' do
        expect(page).to have_content('Category Title')
        expect(page).to have_content('Category Details')
      end
    end

    context 'when all form fields were not filled up and submitted' do
      before do
        click_create
      end

      it 'does not create a category' do
        expect(subject).to eq nil
        expect(subject_count).to eq 0
      end

      it 'redirects back to form' do
        expect(page).to have_current_path(categories_path)
      end

      context 'with title blank' do
        it 'raises an error' do
          expect(page).to have_content('blank')
        end
      end
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
