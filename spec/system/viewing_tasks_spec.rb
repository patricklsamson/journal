require 'rails_helper'

RSpec.describe 'ViewingTasks', type: :system do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  let(:category) do
    Category.create(title: 'Category Title',
                    details: 'Category Details',
                    user_id: user.id)
  end

  before do
    driven_by(:rack_test)

    sign_in user
    category
  end

  describe Task do
    subject do
      described_class.create(details: 'Task Details',
                             priority: Date.today,
                             user_id: user.id,
                             category_id: category.id)
    end

    before do
      subject
      visit categories_path
    end

    context 'when navigating in page of all categories' do
      it 'shows task' do
        expect(page).to have_content(subject.details)
      end
    end

    context 'when navigating inside a category' do
      before do
        find("a[href='/categories/#{category.id}']").click
      end

      it 'shows task' do
        expect(page).to have_content(subject.details)
      end
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
