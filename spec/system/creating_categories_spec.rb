require 'rails_helper'

RSpec.describe 'CreatingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }

  let(:category) { Category.find_by(title: 'Category Title') }
  let(:category_id) { category.id }
  let(:category_title) { category.title }
  let(:category_details) { category.details }
  let(:category_count) { Category.count }

  before :each do
    visit root_path
    click_new_category
  end

  it 'redirects to form' do
    expect(page).to have_current_path(new_category_path)
  end

  context 'when all form fields are filled up and submitted' do
    before :each do
      fill_in 'Title', with: 'Category Title'
      fill_in 'Details', with: 'Category Details'
      click_create_category
    end

    it 'redirects to created category' do
      expect(page).to have_current_path(category_path(category_id))
    end

    it 'renders page with submitted inputs' do
      expect(page).to have_content('Category Title')
      expect(page).to have_content('Category Details')
    end

    it 'creates a category' do
      expect(category_title).to eq('Category Title')
      expect(category_details).to eq('Category Details')
      expect(category_count).to eq 1
    end
  end

  context 'when all form fields are not filled up and submitted' do
    before :each do
      click_create_category
    end

    it 'redirects to form' do
      expect(page).to have_current_path(categories_path)
    end

    it 'raises an error' do
      expect(page).to have_content('blank')
    end

    it 'does not create a category' do
      expect(category_count).to eq 0
      expect(category).to eq nil
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
