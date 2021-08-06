require 'rails_helper'

RSpec.describe 'EditingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:click_update_category) { find('input[type="submit"]').click }
  let(:click_edit_category) { find("a[href='/categories/#{category_id}/edit']").click }

  let(:category) { Category.find_by(title: 'Category Title') }
  let(:category_id) { category.id }
  let(:category_title) { category.title }
  let(:category_details) { category.details }
  let(:category_count) { Category.count }

  let(:category_edited) { Category.find_by(title: 'Category Title Edited') }
  let(:category_edited_title) { category_edited.title }
  let(:category_edited_details) { category_edited.details }

  before :each do
    visit root_path
    click_new_category

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    click_edit_category
  end

  it 'redirects to form' do
    expect(page).to have_current_path(edit_category_path(category_id))
  end

  context 'when all form fields are filled up with new inputs and submitted' do
    before :each do
      fill_in 'Title', with: 'Category Title Edited'
      fill_in 'Details', with: 'Category Details Edited'
      click_update_category
    end

    it 'redirects to edited category' do
      expect(page).to have_current_path(category_path(category_id))
    end

    it 'renders page with submitted inputs' do
      expect(page).to have_content('Category Title Edited')
      expect(page).to have_content('Category Details Edited')
    end

    it 'edits the category' do
      expect(category_count).to eq 1
      expect(category_edited_title).to eq('Category Title Edited')
      expect(category_edited_details).to eq('Category Details Edited')
    end
  end

  context 'when all form fields are filled up with blank inputs and submitted' do
    before :each do
      fill_in 'Title', with: ''
      fill_in 'Details', with: ''
      click_update_category
    end

    it 'redirects to same page' do
      expect(page).to have_current_path(category_path(category_id))
    end

    it 'raises an error' do
      expect(page).to have_content('blank')
    end

    it 'does not edit the category' do
      expect(category_count).to eq 1
      expect(category_title).to eq('Category Title')
      expect(category_details).to eq('Category Details')
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
