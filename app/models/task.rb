class Task < ApplicationRecord
  validates :details, presence: true,
                      uniqueness: true
end
