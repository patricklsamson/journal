require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:category_create) do
    Category.create(title: 'Category Title',
                    details: 'Category Details')
  end

  before :each do
    category_create
  end

  subject do
    described_class.new(details: 'Task Details',
                        category_id: category_create.id)
  end

  let(:task_count) { Task.count }

  let(:task_create) do
    Task.create(details: subject.details,
                category_id: subject.category_id)
  end

  let(:task_on_category) { Task.reflect_on_association(:category).macro }

  context 'when initialized' do
    it 'counts to zero to begin with' do
      expect(task_count).to eq 0
    end

    it 'counts to one after adding one' do
      task_create
      expect(task_count).to eq 1
    end
  end

  context 'when all attributes are valid' do
    it 'does validate' do
      category_create
      expect(subject).to be_valid
    end
  end

  context 'when details is not present' do
    it 'does not validate' do
      subject.details = nil
      expect(subject).to_not be_valid
    end
  end

  context 'when details is not unique' do
    it 'does not validate' do
      task_create
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

  context 'when associated' do
    it 'belongs to a category' do
      expect(task_on_category).to eq :belongs_to
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
