class Task < ApplicationRecord
  validates :details, presence: true,
                      uniqueness: true,
                      length: { minimum: 10 }

  belongs_to :category
end
