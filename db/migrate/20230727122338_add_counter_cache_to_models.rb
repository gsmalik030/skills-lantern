class AddCounterCacheToModels < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :enrollments_count, :integer, default: 0, null: false
  end
end
