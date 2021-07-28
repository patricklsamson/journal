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

  # pending "add some examples to (or delete) #{__FILE__}"
end
