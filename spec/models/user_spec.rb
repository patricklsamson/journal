require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has many categories' do
    expect(User.reflect_on_association(:categories).macro).to eq :has_many
  end

  it 'has many tasks' do
    expect(User.reflect_on_association(:tasks).macro).to eq :has_many
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
