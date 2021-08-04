class Task < ApplicationRecord
  validates :details, presence: true
end
