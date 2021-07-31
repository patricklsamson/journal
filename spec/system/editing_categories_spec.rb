require 'rails_helper'

RSpec.describe 'EditingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:id) { Category.find_by(title: 'Category Title').id }
  let(:click_edit_category) { find("a[href='/categories/#{id}/edit']").click }
  let(:click_update_category) { find('input[type="submit"]').click }
  let(:category_count) { Category.count }
  let(:category) { Category.find_by(title: 'Category Title Edited') }

  it 'edits a category' do
    visit root_path
    click_new_category

    expect(page).to have_current_path(new_category_path)
    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    expect(page).to have_current_path(category_path(id))
    expect(page).to have_content('Category Title')
    expect(page).to have_content('Category Details')
    click_edit_category

    expect(page).to have_current_path(edit_category_path(id))
    fill_in 'Title', with: 'Category Title Edited'
    fill_in 'Details', with: 'Category Details Edited'
    click_update_category

    expect(page).to have_current_path(category_path(id))
    expect(page).to have_content('Category Title Edited')
    expect(page).to have_content('Category Details Edited')

    expect(category_count).to eq 1
    expect(category.title).to eq('Category Title Edited')
    expect(category.details).to eq('Category Details Edited')
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
