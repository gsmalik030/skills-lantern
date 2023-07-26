class AddFieldsToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :short_description, :text
    add_column :courses, :language, :string, default: "English", null: false
    add_column :courses, :level, :string, default: "Beginner", null: false
    add_column :courses, :price, :float, default: 0.0, null: false
  end
end
