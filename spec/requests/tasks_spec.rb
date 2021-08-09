require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password')
  end

  let(:category) do
    Category.create(title: 'Category Title',
                    details: 'Category Details',
                    user_id: user.id)
  end

  before do
    sign_in user
    category
  end

  describe Task do
    let(:valid_attributes) do
      {
        details: 'Task Details',
        priority: Date.today,
        user_id: user.id,
        category_id: category.id
      }
    end

    let(:invalid_attributes) do
      {
        details: nil,
        priority: nil,
        user_id: nil,
        category_id: nil
      }
    end

    subject { described_class.create(valid_attributes) }
    let(:subject_count) { Task.count }

    describe 'GET /edit' do
      before do
        get edit_category_task_path(category, subject)
      end

      it 'responds sucessfully' do
        expect(response).to be_successful
      end

      # pending "add some examples (or delete) #{__FILE__}"
    end

    describe 'POST /create' do
      context 'when valid' do
        before do
          subject
          post category_tasks_path(category), params: { task: valid_attributes }
        end

        it 'redirects to its category' do
          expect(response).to redirect_to(category_path(category))
        end
      end

      context 'when invalid' do
        before do
          post category_tasks_path(category), params: { task: invalid_attributes }
        end

        it 'redirects to its category' do
          expect(response).to redirect_to(category_path(category))
        end
      end
    end

    describe 'PATCH /update' do
      let(:new_attributes) do
        {
          details: 'Task Details Edited',
          priority: Date.tomorrow
        }
      end

      context 'when valid' do
        before do
          patch category_task_path(category, subject), params: { task: new_attributes }
        end

        it 'redirects to itself' do
          expect(response).to redirect_to(category_path(category))
        end
      end

      context 'when invalid' do
        before do
          patch category_task_path(category, subject), params: { task: invalid_attributes }
        end

        it 'responds successfully' do
          expect(response).to be_successful
        end
      end
    end

    describe 'DELETE /destroy' do
      before do
        delete category_task_path(category, subject)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(category_path(category))
      end
    end
  end
end
