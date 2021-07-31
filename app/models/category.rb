class Category < ApplicationRecord
  validates :title, presence: true,
                    uniqueness: true
  validates :details, presence: true,
                      length: { minimum: 10 }
end
