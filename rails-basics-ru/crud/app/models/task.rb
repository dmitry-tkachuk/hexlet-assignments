# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  validates :creator, presence: true
  validates_length_of :creator, maximum: 30, message: 'less than 30 pls'
  validates_length_of :performer, maximum: 30, message: 'less than 30 pls'
  validates :completed, inclusion: { in: [true, false] }
end
