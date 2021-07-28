require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'model existence test' do
    it 'has none to begin with' do
      expect(Category.count).to eq 0
    end

    it 'has one after adding one' do
      Category.create(title: 'Programming',
                      details: 'Coding tasks for the day')
      expect(Category.count).to eq 1
    end
  end

  context 'validation test' do
    subject do
      described_class.new(title: 'Programming',
                          details: 'Coding tasks for the day')
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is valid without details' do
      subject.details = nil
      expect(subject).to be_valid
    end

    it 'should have a unique title' do
      Category.create(title: 'Programming')
      another = Category.create(title: 'Programming')
      expect(another).to_not be_valid
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
