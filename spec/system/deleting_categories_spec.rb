require 'rails_helper'

RSpec.describe 'DeletingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe Category do
    let(:attributes) do
      {
        title: 'Category Title',
        details: 'Category Details'
      }
    end

    subject { described_class.create(attributes) }
    let(:click_destroy) { find("a[href='/categories/#{subject.id}']").click }

    before do
      subject
      visit category_path(subject)
    end

    context 'when category was created' do
      it 'redirects to itself' do
        expect(page).to have_current_path(category_path(subject))
      end
    end

    context 'with that category can be deleted' do
      before do
        click_destroy
      end

      it 'deletes the category' do
        expect(Category.find_by(attributes)).to eq nil
        expect(Category.count).to eq 0
      end
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
