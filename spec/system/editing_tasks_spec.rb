require 'rails_helper'

RSpec.describe 'EditingTasks', type: :system do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  let(:category) do
    Category.create(title: 'Category Title',
                    details: 'Category Details',
                    user_id: user.id)
  end

  let(:attributes) do
    {
      details: 'Task Details',
      priority: Date.today,
      user_id: user.id,
      category_id: category.id
    }
  end

  let(:task) do
    Task.create(attributes)
  end

  before do
    driven_by(:rack_test)

    sign_in user
    category
    task

    visit category_path(category)
    find("a[href='/categories/#{category.id}/tasks/#{task.id}/edit']").click

    fill_in 'Details', with: 'Task Details Edited'
    fill_in 'task[priority]', with: Date.tomorrow
    find('input[type="submit"]').click
  end

  it 'updates task' do
    expect(Task.find_by(attributes)).to eq nil
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
