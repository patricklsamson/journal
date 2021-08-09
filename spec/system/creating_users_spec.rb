require 'rails_helper'

RSpec.describe 'CreatingUsers', type: :system do
  before do
    driven_by(:rack_test)

    visit root_path
    find('a[href="/users/sign_up"]').click

    fill_in 'Email', with: 'example@mail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[type="submit"]').click
  end

  let(:user) do
    User.find_by(email: 'example@mail.com')
  end

  it 'creates user' do
    expect(user).to_not eq nil
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
