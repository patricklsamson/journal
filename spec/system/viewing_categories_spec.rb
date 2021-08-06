require 'rails_helper'

RSpec.describe 'ViewingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:click_show_category) { find("a[href='/categories/#{category_id}']").click }

  let(:category_id) { Category.find_by(title: 'Category Title').id }

  before :each do
    visit root_path
    click_new_category

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    visit root_path
    click_show_category
  end

  it 'redirects to the category' do
    expect(page).to have_current_path(category_path(category_id))
  end

  it 'renders page with its contents' do
    expect(page).to have_content('Category Title')
    expect(page).to have_content('Category Details')
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
