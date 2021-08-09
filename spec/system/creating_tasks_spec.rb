require 'rails_helper'

RSpec.describe 'CreatingTasks', type: :system do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  let(:category) do
    Category.create(title: 'Category Title',
                    details: 'Category Details',
                    user_id: user.id)
  end

  let(:task) do
    Task.find_by(details: 'Task Details',
                 priority: Date.today)
  end

  before do
    driven_by(:rack_test)

    sign_in user
    category
    visit category_path(category)

    fill_in 'Details', with: 'Task Details'
    fill_in 'task[priority]', with: Date.today
    find('input[type="submit"]').click
  end

  it 'creates a task' do
    expect(task).to_not eq nil
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
