class Task < ApplicationRecord
  belongs_to :category

  validates :details, presence: true,
                      uniqueness: true,
                      length: { minimum: 10 }
end
