require 'rails_helper'

RSpec.describe "CreatingCategories", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'enables me to create categories' do
    visit '/categories/new'

    fill_in 'Title', with: 'Programming'
    fill_in 'Details', with: 'Coding tasks for the day'

    click_on 'Create Category'

    expect(page).to have_content('Programming')
    expect(page).to have_content('Coding tasks for the day')

    category = Category.order('id').last
    expect(category.title).to eq('Programming')
    expect(category.description).to eq('Coding tasks for the day')
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
