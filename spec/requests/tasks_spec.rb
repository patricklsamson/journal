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

  describe Task do
    let(:valid_attributes) do
      {
        details: 'Task Details',
        priority: Date.current,
        done: false,
        user_id: user.id,
        category_id: category.id
      }
    end

    let(:invalid_attributes) do
      {
        details: nil,
        priority: nil,
        done: nil,
        user_id: nil,
        category_id: nil
      }
    end

    subject { described_class.create(valid_attributes) }

    context 'when user signed in' do
      before do
        sign_in user
        category
      end

      describe 'GET /index' do
        it 'raises error' do
          expect do
            get category_tasks_url(category)
          end.to raise_error(ActionController::RoutingError)
        end

        # pending "add some examples (or delete) #{__FILE__}"
      end

      describe 'GET /show' do
        it 'raises error' do
          expect do
            get category_task_url(category, subject)
          end.to raise_error(ActionController::RoutingError)
        end
      end

      describe 'GET /new' do
        it 'raises error' do
          expect do
            get "/categories/#{category.id}/tasks/new"
          end.to raise_error(ActionController::RoutingError)
        end
      end

      describe 'GET /edit' do
        before do
          get edit_category_task_url(category, subject)
        end

        it 'responds sucessfully' do
          expect(response).to be_successful
        end
      end

      describe 'POST /create' do
        context 'when valid' do
          before do
            post category_tasks_url(category), params: { task: valid_attributes }
          end

          it 'redirects to its category' do
            expect(response).to redirect_to(category_url(category))
          end
        end

        context 'when invalid' do
          before do
            post category_tasks_url(category), params: { task: invalid_attributes }
          end

          it 'redirects to its category' do
            expect(response).to redirect_to(category_url(category))
          end
        end
      end

      describe 'PATCH /update' do
        let(:new_attributes) do
          {
            details: 'Task Details Edited',
            priority: Date.current.tomorrow,
            done: true
          }
        end

        context 'when valid' do
          before do
            patch category_task_url(category, subject), params: { task: new_attributes }
          end

          it 'redirects to base url' do
            expect(response).to redirect_to("#{request.base_url}/")
          end
        end

        context 'when invalid' do
          before do
            patch category_task_url(category, subject), params: { task: invalid_attributes }
          end

          it 'responds successfully' do
            expect(response).to be_successful
          end
        end
      end

      describe 'DELETE /destroy' do
        before do
          delete category_task_url(category, subject)
        end

        it 'redirects to all categories' do
          expect(response).to redirect_to(category_url(category))
        end
      end
    end

    context 'when user not signed in' do
      before do
        category
      end

      describe 'GET /index' do
        it 'raises error' do
          expect do
            get category_tasks_url(category)
          end.to raise_error(ActionController::RoutingError)
        end
      end

      describe 'GET /show' do
        it 'raises error' do
          expect do
            get category_task_url(category, subject)
          end.to raise_error(ActionController::RoutingError)
        end
      end

      describe 'GET /new' do
        it 'raises error' do
          expect do
            get "/categories/#{category.id}/tasks/new"
          end.to raise_error(ActionController::RoutingError)
        end
      end

      describe 'GET /edit' do
        before do
          get edit_category_task_url(category, subject)
        end

        it 'redirects to log in' do
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end
