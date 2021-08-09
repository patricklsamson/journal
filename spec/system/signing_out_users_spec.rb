require 'rails_helper'

RSpec.describe 'SigningOutUsers', type: :system do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  before do
    driven_by(:rack_test)

    sign_in user
    visit root_path
    find('a[href="/users/sign_out"]').click
  end

  it 'signs out user' do
    expect(page).to_not have_css('a[href="/users/sign_out"]')
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
