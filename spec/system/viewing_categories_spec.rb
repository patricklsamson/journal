require 'rails_helper'

RSpec.describe 'ViewingCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:category_create) { Category.create(title: 'Category Title', details: 'Category Details') }
  let(:category_id) { Category.find_by(title: 'Category Title').id }

  let(:click_show_category) { find("a[href='/categories/#{category_id}']").click }

  context 'when navigating in page of all categories' do
    context 'when there are no categories yet' do
      before do
        visit categories_path
      end

      it 'shows heading' do
        expect(page).to have_content('Categories')
      end

      it 'shows "create" message' do
        expect(page).to have_content('Create a new category now!')
      end
    end

    context 'when a category was created' do
      before :each do
        category_create
        visit categories_path
      end

      it 'shows created category' do
        expect(page).to have_content('Category Title')
        expect(page).to have_content('Category Details')
      end

      it 'does not show "create" message' do
        expect(page).to_not have_content('Create a new category now!')
      end

      context 'when viewing that category created' do
        before :each do
          click_show_category
        end

        it 'goes to the category' do
          expect(page).to have_current_path(category_path(category_id))
        end

        it 'renders page with its contents' do
          expect(page).to have_content('Category Title')
          expect(page).to have_content('Category Details')
        end
      end
    end
  end

  # pending "add some scenarios (or delete) #{__FILE__}"
end
