require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.create(email: 'example@mail.com',
                           password: 'password')
  end

  context 'with associations' do
    it 'has many categories' do
      expect(User.reflect_on_association(:categories).macro).to eq :has_many
    end

    it 'has many tasks' do
      expect(User.reflect_on_association(:tasks).macro).to eq :has_many
    end
  end

  context 'with dependents' do
    let(:category) do
      Category.create(title: 'Category Title',
                      details: 'Category Details',
                      user_id: subject.id)
    end

    let(:task) do
      Task.create(details: 'Task Details',
                  priority: Date.today,
                  user_id: subject.id,
                  category_id: category.id)
    end

    it 'deletes its categories' do
      category
      subject.destroy
      expect(Category.find_by(user_id: subject.id)).to eq nil
    end

    it 'deletes its tasks' do
      category
      task
      subject.destroy
      expect(Task.find_by(user_id: subject.id)).to eq nil
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
