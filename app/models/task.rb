class Task < ApplicationRecord
  belongs_to :category

  validates :details, presence: true,
                      uniqueness: true,
                      length: { minimum: 10 }

  validate :priority_date_cannot_be_in_the_past

  def priority_date_cannot_be_in_the_past
    errors.add(:priority, "can't be in the past") if priority.present? && priority < Date.today
  end
end
