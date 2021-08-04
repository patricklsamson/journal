require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:attributes) do
    {
      title: 'Category Title',
      details: 'Category Details'
    }
  end

  let(:new_attributes) do
    {
      title: 'Category Title Edited',
      details: 'Category Details Edited'
    }
  end

  subject do
    Category.create(attributes)
  end

  let(:category_count) { Category.count }

  describe 'GET /index' do
    it 'finishes method successfully' do
      get categories_path
      expect(response).to be_successful
    end

    # pending "add some examples (or delete) #{__FILE__}"
  end

  describe 'GET /show' do
    it 'finishes method successfully' do
      get category_path(subject)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'finishes method successfully' do
      get new_category_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'finishes method successfully' do
      get edit_category_path(subject)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    it 'finishes method successfully' do
      post categories_path(subject), params: { category: attributes }
      expect(category_count).to eq 1
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    it 'finishes method successfully' do
      patch category_path(subject), params: { category: new_attributes }
      expect(category_count).to eq 1
      expect(response).to redirect_to(:category)
    end
  end

  describe 'DELETE /destroy' do
    it 'finishes method successfully' do
      delete category_path(subject)
      expect(category_count).to eq 0
      expect(response).to redirect_to(root_path)
    end
  end
end
