require 'rails_helper'

RSpec.describe 'EditingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:category_create) { Category.create(title: 'Category Title', details: 'Category Details') }
  let(:category) { Category.find_by(title: 'Category Title') }
  let(:category_id) { category.id }
  let(:category_title) { category.title }
  let(:category_details) { category.details }

  let(:category_edited) { Category.find_by(title: 'Category Title Edited') }
  let(:category_edited_title) { category_edited.title }
  let(:category_edited_details) { category_edited.details }

  let(:click_edit_category) { find("a[href='/categories/#{category_id}/edit']").click }
  let(:click_update_category) { find('input[type="submit"]').click }

  before :each do
    category_create
    visit category_path(category_id)
    click_edit_category
  end

  context 'when category was created it redirects to itself then it can be edited' do
    it 'goes to form' do
      expect(page).to have_current_path(edit_category_path(category_id))
    end
  end

  context 'when all form fields were filled up with new inputs and submitted' do
    before :each do
      fill_in 'Title', with: 'Category Title Edited'
      fill_in 'Details', with: 'Category Details Edited'
      click_update_category
    end

    it 'updates category' do
      expect(category_edited_title).to eq('Category Title Edited')
      expect(category_edited_details).to eq('Category Details Edited')
    end

    it 'redirects to updated category' do
      expect(page).to have_current_path(category_path(category_id))
    end

    it 'renders page with submitted inputs' do
      expect(page).to have_content('Category Title Edited')
      expect(page).to have_content('Category Details Edited')
    end
  end

  context 'when all form fields are filled up with blank inputs and submitted' do
    before :each do
      fill_in 'Title', with: ''
      fill_in 'Details', with: ''
      click_update_category
    end

    it 'does not update category' do
      expect(category_title).to eq('Category Title')
      expect(category_details).to eq('Category Details')
    end

    it 'redirects back to form' do
      expect(page).to have_current_path(category_path(category_id))
    end

    context 'with title blank' do
      it 'raises an error' do
        expect(page).to have_content('blank')
      end
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
