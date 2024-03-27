# frozen_string_literal: true

class AddDefaultStatusToTasks < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tasks, :status, 'new'
  end
end
