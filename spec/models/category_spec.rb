require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category_count) { Category.count }
  let(:category_on_tasks) { Category.reflect_on_association(:tasks).macro }

  let(:category_create) do
    Category.create(title: subject.title,
                    details: subject.details)
  end

  subject do
    described_class.new(title: 'Category Title',
                        details: 'Category Details')
  end

  context 'when initialized' do
    it 'counts to zero to begin with' do
      expect(category_count).to eq 0
    end

    it 'counts to one after adding one' do
      category_create
      expect(category_count).to eq 1
    end
  end

  context 'with valid attributes' do
    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  context 'without a title' do
    it 'does not validate' do
      subject.title = nil || ''
      expect(subject).to_not be_valid
    end
  end

  context 'when title is not unique' do
    it 'does not validate' do
      category_create
      subject.title = 'Category Title'
      expect(subject).to_not be_valid
    end
  end

  context 'without details' do
    it 'does validate' do
      subject.details = nil
      expect(subject).to be_valid
    end
  end

  context 'with associations' do
    it 'has many tasks' do
      expect(category_on_tasks).to eq :has_many
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
