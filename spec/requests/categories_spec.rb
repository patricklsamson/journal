require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:valid_attributes) do
    {
      title: 'Category Title',
      details: 'Category Details'
    }
  end

  let(:invalid_attributes) do
    {
      title: nil,
      details: nil
    }
  end

  let(:new_attributes) do
    {
      title: 'Category Title Edited',
      details: 'Category Details Edited'
    }
  end

  subject { Category.create(valid_attributes) }
  let(:category_invalid) { Category.create(invalid_attributes) }
  let(:category_updated) { Category.find_by(new_attributes) }
  let(:category_count) { Category.count }

  describe 'GET /index' do
    before do
      get categories_path
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end

    # pending "add some examples (or delete) #{__FILE__}"
  end

  describe 'GET /show' do
    before do
      get category_path(subject)
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    before do
      get new_category_path
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    before do
      get edit_category_path(subject)
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'when valid' do
      before :each do
        post categories_path(subject), params: { category: valid_attributes }
      end

      it 'creates a category' do
        expect(category_count).to eq 1
      end

      it 'responds successfully' do
        expect(response).to be_successful
      end
    end

    context 'when invalid' do
      before :each do
        post categories_path(category_invalid), params: { category: invalid_attributes }
      end

      it 'does not create a category' do
        expect(category_count).to eq 0
      end

      it 'responds successfully' do
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'when valid' do
      before do
        patch category_path(subject), params: { category: new_attributes }
      end

      it 'updates category' do
        expect(category_updated).to_not eq nil
      end

      it 'redirects to itself' do
        expect(response).to redirect_to(category_path(subject))
      end
    end

    context 'when invalid' do
      before do
        patch category_path(subject), params: { category: invalid_attributes }
      end

      it 'does not update category' do
        expect(category_updated).to eq nil
      end

      it 'responds successfully' do
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      delete category_path(subject)
    end

    it 'redirects to root path' do
      expect(category_count).to eq 0
      expect(response).to redirect_to(root_path)
    end
  end
end
