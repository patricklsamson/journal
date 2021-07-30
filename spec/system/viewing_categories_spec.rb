require 'rails_helper'

RSpec.describe "ViewingCategories", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'enables me to view a category' do
    visit '/categories/new'

    fill_in 'Title', with: 'Programming'
    fill_in 'Details', with: 'Coding tasks for the day'

    click_on 'Create Category'

    visit root_path
    click_link 'Programming'

    expect(page).to have_content('Coding tasks for the day')
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
