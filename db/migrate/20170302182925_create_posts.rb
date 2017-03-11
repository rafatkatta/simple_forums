class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :poster, index: true, foreign_key: { to_table: :users }
      t.references :topic, foreign_key: true
      t.timestamps
    end
  end
end
