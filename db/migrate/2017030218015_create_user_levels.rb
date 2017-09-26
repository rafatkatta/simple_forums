class CreateUserLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :user_levels do |t|
      t.string :description
      t.integer :level

      t.timestamps
    end
  end
end
