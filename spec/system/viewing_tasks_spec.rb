require 'rails_helper'

RSpec.describe 'ViewingTasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:click_new_category) { find('a[href="/categories/new"]').click }
  let(:click_create_category) { find('input[type="submit"]').click }
  let(:click_create_task) { find('input[type="submit"]').click }
  let(:click_show_category) { find("a[href='/categories/#{category_id}']").click }

  let(:date_today) { Date.today }

  let(:category_id) { Category.find_by(title: 'Category Title').id }

  before :each do
    visit root_path
    click_new_category

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    click_create_category

    fill_in 'Details', with: 'Task Details'
    fill_in 'task[priority]', with: date_today
    click_create_task

    visit root_path
    click_show_category
  end

  it 'redirects to its category' do
    expect(page).to have_current_path(category_path(category_id))
  end

  it 'renders page with its contents' do
    expect(page).to have_content('Task Details')
    expect(page).to have_content(date_today)
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
