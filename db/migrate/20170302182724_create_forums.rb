class CreateForums < ActiveRecord::Migration[5.0]
  def change
    create_table :forums do |t|
      t.string :name
      t.text :description
      t.references :admin, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
