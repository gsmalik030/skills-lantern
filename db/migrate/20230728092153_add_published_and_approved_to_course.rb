class AddPublishedAndApprovedToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :is_published, :boolean, default: false
    add_column :courses, :is_approved, :boolean, default: false
  end
end
