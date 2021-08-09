require 'rails_helper'

RSpec.describe 'CreatingCategories', type: :system do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  let(:category) do
    Category.find_by(title: 'Category Title',
                     details: 'Category Details')
  end

  before do
    driven_by(:rack_test)

    sign_in user
    visit categories_path
    find('a[href="/categories/new"]').click

    fill_in 'Title', with: 'Category Title'
    fill_in 'Details', with: 'Category Details'
    find('input[type="submit"]').click
  end

  it 'creates category' do
    expect(category).to_not eq nil
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
