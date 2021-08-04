require 'rails_helper'

RSpec.describe 'CreatingCategories', type: :system do
  before :each do
    driven_by(:rack_test)

    visit root_path
    click_new_category

    expect(page).to have_current_path(new_category_path)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:id) { Category.find_by(title: 'Category Title').id }
  let(:category_count) { Category.count }
  let(:category) { Category.find_by(title: 'Category Title') }

  it 'creates a category' do
    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    expect(page).to have_current_path(category_path(id))
    expect(page).to have_content('Category Title')
    expect(page).to have_content('Category Details')

    expect(category_count).to eq 1
    expect(category.title).to eq('Category Title')
    expect(category.details).to eq('Category Details')
  end

  context 'when invalid' do
    it 'raises an error' do
      fill_in 'Title', with: ''
      fill_in 'Details', with: ''
      click_create_category

      expect(page).to have_current_path(categories_path)
      expect(page).to have_content('blank')
      expect(page).to have_content('minimum')

      expect(category_count).to eq 0
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
