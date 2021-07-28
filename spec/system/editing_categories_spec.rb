require 'rails_helper'

RSpec.describe "EditingCategories", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'enables me to edit a title of category' do
    visit '/categories/new'

    fill_in 'Title', with: 'Programming'
    fill_in 'Details', with: 'Coding tasks for the day'

    click_on 'Create Category'

    id = Category.last.id.to_s
    visit "/categories/#{id}"
    click_link 'Edit'

    expect(page).to have_content('Edit Category')
    fill_in 'Title', with: 'Programming Edited'
    click_on 'Update Category'

    expect(page).to have_content('Programming Edited')
    category = Category.find(id)
    expect(category.title).to eq('Programming Edited')
  end

  it 'enables me to edit details of category' do
    visit '/categories/new'

    fill_in 'Title', with: 'Programming'
    fill_in 'Details', with: 'Coding tasks for the day'

    click_on 'Create Category'

    id = Category.last.id.to_s
    visit "/categories/#{id}"
    click_link 'Edit'

    expect(page).to have_content('Edit Category')
    fill_in 'Details', with: 'Coding tasks for the day edited'
    click_on 'Update Category'

    expect(page).to have_content('Programming Edited')
    category = Category.find(id)
    expect(category.details).to eq('Programming Edited')
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
