require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    described_class.new(title: 'Category Title',
                        details: 'Category Details')
  end

  context 'when initialized' do
    let(:subject_count) { Category.count }

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

  context 'without a title' do
    it 'does not validate' do
      subject.title = nil || ''
      expect(subject).to_not be_valid
    end
  end

  context 'when title is not unique' do
    before do
      Category.create(title: 'Category Title',
                      details: 'Category Details')
    end

    it 'does not validate' do
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
      expect(Category.reflect_on_association(:tasks).macro).to eq :has_many
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
