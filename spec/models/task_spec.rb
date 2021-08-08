require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:date_today) { Date.today }
  let(:date_yesterday) { date_today - 1 }

  let(:category_create) do
    Category.create(title: 'Category Title',
                    details: 'Category Details')
  end

  subject do
    described_class.new(details: 'Task Details',
                        priority: date_today,
                        category_id: category_create.id)
  end

  let(:task_count) { Task.count }
  let(:task_on_category) { Task.reflect_on_association(:category).macro }

  let(:task_create) do
    Task.create(details: subject.details,
                priority: subject.priority,
                category_id: subject.category_id)
  end

  before :each do
    category_create
  end

  context 'when initialized' do
    it 'counts to zero to begin with' do
      expect(task_count).to eq 0
    end

    it 'counts to one after adding one' do
      task_create
      expect(task_count).to eq 1
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

  context 'without priority date' do
    it 'does validate' do
      subject.priority = nil
      expect(subject).to be_valid
    end
  end

  context 'when priority date is in the past' do
    it 'does not validate' do
      subject.priority = date_yesterday
      expect(subject).to_not be_valid
    end
  end

  context 'with associations' do
    it 'belongs to a category' do
      expect(task_on_category).to eq :belongs_to
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
