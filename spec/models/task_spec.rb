require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:category) do
    Category.create(title: 'Category Title',
                    details: 'Category Details')
  end

  subject do
    described_class.new(details: 'Task Details',
                        priority: Date.today,
                        category_id: category.id)
  end

  before do
    category
  end

  context 'when initialized' do
    let(:subject_count) { Task.count }

    it 'counts to zero to begin with' do
      expect(subject_count).to eq 0
    end

    it 'counts to one after adding one' do
      subject.save
      expect(subject_count).to eq 1
    end
  end

  context 'with valid attributes' do
    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  context 'without details' do
    it 'does not validate' do
      subject.details = nil
      expect(subject).to_not be_valid
    end
  end

  context 'when details is not unique' do
    before do
      Task.create(details: subject.details,
                  priority: subject.priority,
                  category_id: subject.category_id)
    end

    it 'does not validate' do
      subject.details = 'Task Details'
      expect(subject).to_not be_valid
    end
  end

  context 'when details is less than 10 characters' do
    it 'does not validate' do
      subject.details = 'A' * 9
      expect(subject).to_not be_valid
    end
  end

  context 'without priority date' do
    it 'does validate' do
      subject.priority = nil
      expect(subject).to be_valid
    end
  end

  context 'when priority date is in the past' do
    it 'does not validate' do
      subject.priority -= 10
      expect(subject).to_not be_valid
    end
  end

  context 'with associations' do
    it 'belongs to a category' do
      expect(Task.reflect_on_association(:category).macro).to eq :belongs_to
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
