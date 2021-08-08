require 'rails_helper'

RSpec.describe 'EditingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe Category do
    let(:attributes) do
      {
        title: 'Category Title',
        details: 'Category Details'
      }
    end

    subject { described_class.create(attributes) }
    let(:subject_find) { Category.find_by(attributes) }
    let(:subject_find_edited) { Category.find_by(title: 'Category Title Edited') }

    let(:click_edit) { find("a[href='/categories/#{subject.id}/edit']").click }
    let(:click_update) { find('input[type="submit"]').click }

    before do
      subject
      visit category_path(subject)
      click_edit
    end

    context 'when category was created it redirects to itself then it can be edited' do
      it 'goes to form' do
        expect(page).to have_current_path(edit_category_path(subject))
      end
    end

    context 'when all form fields were filled up with new inputs and submitted' do
      before do
        fill_in 'Title', with: 'Category Title Edited'
        fill_in 'Details', with: 'Category Details Edited'
        click_update
      end

      it 'updates category' do
        expect(subject_find_edited.title).to eq('Category Title Edited')
        expect(subject_find_edited.details).to eq('Category Details Edited')
      end

      it 'redirects to updated category' do
        expect(page).to have_current_path(category_path(subject))
      end

      it 'renders page with submitted inputs' do
        expect(page).to have_content('Category Title Edited')
        expect(page).to have_content('Category Details Edited')
      end
    end

    context 'when all form fields are filled up with blank inputs and submitted' do
      before do
        fill_in 'Title', with: ''
        fill_in 'Details', with: ''
        click_update
      end

      it 'does not update category' do
        expect(subject_find.title).to eq('Category Title')
        expect(subject_find.details).to eq('Category Details')
      end

      it 'redirects back to form' do
        expect(page).to have_current_path(category_path(subject))
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
