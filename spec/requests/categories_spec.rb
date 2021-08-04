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
  let(:category_count) { Category.count }

  describe 'GET /index' do
    it 'responds successfully' do
      get categories_path
      expect(response).to be_successful
    end

    # pending "add some examples (or delete) #{__FILE__}"
  end

  describe 'GET /show' do
    it 'responds successfully' do
      get category_path(subject)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'responds successfully' do
      get new_category_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'responds successfully' do
      get edit_category_path(subject)
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
      it 'redirects to itself' do
        patch category_path(subject), params: { category: new_attributes }
        expect(category_count).to eq 1
        expect(response).to redirect_to(category_path(subject))
      end
    end

    context 'when invalid' do
      it 'responds successfully' do
        patch category_path(subject), params: { category: invalid_attributes }
        expect(category_count).to eq 1
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'redirects to root path' do
      delete category_path(subject)
      expect(category_count).to eq 0
      expect(response).to redirect_to(root_path)
    end
  end
end
