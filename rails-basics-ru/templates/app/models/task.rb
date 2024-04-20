class Task < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  validates :creator, presence: true
  validates_length_of :creator, maximum: 32, message: "less than 32 if you don't mind"
  validates_length_of :performer, maximum: 32, message: "less than 32 if you don't mind"
  # validates :completed, presence: true
  validates :completed, inclusion: { in: [true, false] }
end
