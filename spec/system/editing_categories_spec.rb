require 'rails_helper'

RSpec.describe 'EditingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:category) { Category.find_by(title: 'Category Title') }
  let(:category_id) { category.id }
  let(:click_edit_category) { find("a[href='/categories/#{category_id}/edit']").click }

  before :each do
    visit root_path
    click_new_category

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    click_edit_category

    expect(page).to have_current_path(edit_category_path(category_id))
  end

  let(:click_update_category) { find('input[type="submit"]').click }
  let(:category_count) { Category.count }
  let(:category_edited) { Category.find_by(title: 'Category Title Edited') }
  let(:category_edited_title) { category_edited.title }
  let(:category_edited_details) { category_edited.details }
  let(:category_title) { category.title }
  let(:category_details) { category.details }

  context 'with title and details' do
    it 'edits a category' do
      fill_in 'Title', with: 'Category Title Edited'
      fill_in 'Details', with: 'Category Details Edited'
      click_update_category

      expect(page).to have_current_path(category_path(category_id))
      expect(page).to have_content('Category Title Edited')
      expect(page).to have_content('Category Details Edited')

      expect(category_count).to eq 1
      expect(category_edited_title).to eq('Category Title Edited')
      expect(category_edited_details).to eq('Category Details Edited')
    end
  end

  context 'with title and without details' do
    it 'edits a category' do
      fill_in 'Title', with: 'Category Title Edited'
      fill_in 'Details', with: ''
      click_update_category

      expect(page).to have_current_path(category_path(category_id))
      expect(page).to have_content('Category Title Edited')

      expect(category_count).to eq 1
      expect(category_edited_title).to eq('Category Title Edited')
      expect(category_edited_details).to eq nil || ''
    end
  end

  context 'without title and details' do
    before :each do
      fill_in 'Title', with: ''
      fill_in 'Details', with: ''
      click_update_category
      expect(page).to have_current_path(category_path(category_id))
    end

    it 'raises an error' do
      expect(page).to have_content('blank')
    end

    it 'does not edit a category' do
      expect(category_count).to eq 1
      expect(category_title).to eq('Category Title')
      expect(category_details).to eq('Category Details')
    end
  end

  context 'without title and with details' do
    before :each do
      fill_in 'Title', with: ''
      fill_in 'Details', with: 'Category Details Edited'
      click_update_category
      expect(page).to have_current_path(category_path(category_id))
    end

    it 'raises an error' do
      expect(page).to have_content('blank')
    end

    it 'does not edit a category' do
      expect(category_count).to eq 1
      expect(category_title).to eq('Category Title')
      expect(category_details).to eq('Category Details')
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
