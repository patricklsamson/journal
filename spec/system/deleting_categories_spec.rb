require 'rails_helper'

RSpec.describe 'DeletingCategories', type: :system do
  before do
    driven_by(:rack_test)

    category_create
    visit category_path(category_id)
  end

  let(:category_create) { Category.create(title: 'Category Title', details: 'Category Details') }
  let(:category_id) { Category.find_by(title: 'Category Title').id }
  let(:category_count) { Category.count }
  let(:category_deleted) { Category.find_by(title: 'Category Title') }

  let(:click_destroy_category) { find("a[href='/categories/#{category_id}']").click }

  context 'when category was created' do
    it 'redirects to itself' do
      expect(page).to have_current_path(category_path(category_id))
    end
  end

  context 'with that category can be deleted' do
    before do
      click_destroy_category
    end

    it 'deletes the category' do
      expect(category_count).to eq 0
      expect(category_deleted).to eq nil
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
