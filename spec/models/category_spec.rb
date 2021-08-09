require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  subject do
    described_class.new(title: 'Category Title',
                        details: 'Category Details',
                        user_id: user.id)
  end

  before do
    user
  end

  context 'with associations' do
    it 'belongs to a user' do
      expect(Category.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'has many tasks' do
      expect(Category.reflect_on_association(:tasks).macro).to eq :has_many
    end
  end

  context 'with valid attributes' do
    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  context 'without a title' do
    before do
      subject.title = nil
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when title is not unique' do
    before do
      Category.create(title: subject.title,
                      details: subject.details,
                      user_id: subject.user_id)

      subject.title = subject.title
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'without details' do
    before do
      subject.details = nil
    end

    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
