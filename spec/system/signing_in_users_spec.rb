require 'rails_helper'

RSpec.describe 'SigningInUsers', type: :system do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  before do
    driven_by(:rack_test)

    user
    visit root_path
    find('a[href="/users/sign_in"]').click

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    find('input[type="submit"]').click
  end

  it 'signs in user' do
    expect(page).to_not have_current_path(new_user_session_path)
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
