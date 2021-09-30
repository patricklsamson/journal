require 'rails_helper'

RSpec.describe 'ViewingCategories', type: :system do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  before do
    driven_by(:rack_test)

    sign_in user
  end

  describe Category do
    subject do
      described_class.create(title: 'Category Title',
                             details: 'Category Details',
                             user_id: user.id)
    end

    before do
      subject
      visit categories_path
    end

    context 'when navigating in page of all categories' do
      it 'shows category' do
        expect(page).to have_content(subject.title)
        expect(page).to have_content(subject.details)
      end
    end

    context 'when accessing a category' do
      before do
        click_on 'Category Title'
      end

      it 'shows category' do
        expect(page).to have_content(subject.title)
        expect(page).to have_content(subject.details)
      end
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
