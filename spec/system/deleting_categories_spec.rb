require 'rails_helper'

RSpec.describe 'DeletingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:category) { Category.find_by(title: 'Category Title') }
  let(:category_id) { category.id }
  let(:click_destroy_category) { find("a[href='/categories/#{id}']").click }
  let(:category_count) { Category.count }

  it 'deletes a category' do
    visit root_path
    click_new_category

    expect(page).to have_current_path(new_category_path)
    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    expect(page).to have_current_path(category_path(category_id))
    expect(page).to have_content('Category Title')
    expect(page).to have_content('Category Details')

    click_destroy_category
    expect(category_count).to eq 0
    expect(category).to eq nil
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
