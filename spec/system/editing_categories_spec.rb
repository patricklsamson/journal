require 'rails_helper'

RSpec.describe 'EditingCategories', type: :system do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  let(:attributes) do
    {
      title: 'Category Title',
      details: 'Category Details',
      user_id: user.id
    }
  end

  let(:category) do
    Category.create(attributes)
  end

  before do
    driven_by(:rack_test)

    sign_in user
    category

    visit category_path(category)
    find("a[href='/categories/#{category.id}/edit']").click

    fill_in 'Title', with: 'Category Title Edited'
    fill_in 'Details', with: 'Category Details Edited'
    find('input[type="submit"]').click
  end

  it 'updates category' do
    expect(Category.find_by(attributes)).to eq nil
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
