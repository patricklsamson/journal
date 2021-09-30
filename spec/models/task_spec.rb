require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  let(:category) do
    Category.create(title: 'Category Title',
                    details: 'Category Details',
                    user_id: user.id)
  end

  subject do
    described_class.new(details: 'Task Details',
                        priority: Date.current,
                        done: false,
                        user_id: user.id,
                        category_id: category.id)
  end

  before do
    user
    category
  end

  context 'with associations' do
    it 'belongs to a user' do
      expect(described_class.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'belongs to a category' do
      expect(described_class.reflect_on_association(:category).macro).to eq :belongs_to
    end
  end

  context 'with valid attributes' do
    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  context 'without details' do
    before do
      subject.details = nil
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when details is not unique' do
    before do
      described_class.create(
        details: subject.details,
        priority: subject.priority,
        done: false,
        user_id: subject.user_id,
        category_id: subject.category_id
      )

      subject.details = subject.details
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when details is less than 10 characters' do
    before do
      subject.details = 'A' * 9
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'without priority date' do
    before do
      subject.priority = nil
    end

    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  context 'when priority date is in the past' do
    before do
      subject.priority -= 10
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
