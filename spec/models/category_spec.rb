require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    described_class.new(title: 'Category Title',
                        details: 'Category Details')
  end

  let(:attributes) do
    {
      title: subject.title,
      details: subject.details
    }
  end

  let(:category_count) { Category.count }
  let(:category_create) { Category.create(attributes) }

  context 'when initialized' do
    it 'counts to zero to begin with' do
      expect(category_count).to eq 0
    end

    it 'counts to one after adding one' do
      category_create
      expect(category_count).to eq 1
    end
  end

  context 'when all attributes are present' do
    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  context 'without a title' do
    it 'does not validate' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end

  context 'without details' do
    it 'does not validate' do
      subject.details = nil
      expect(subject).to_not be_valid
    end
  end

  context 'when title is not unique' do
    it 'does not validate' do
      category_create
      another = Category.create(attributes)
      expect(another).to_not be_valid
    end
  end

  context 'when details is less than 10 characters' do
    it 'does not validate' do
      subject.details = 'A' * 9
      expect(subject).to_not be_valid
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
