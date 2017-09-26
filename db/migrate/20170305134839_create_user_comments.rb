class CreateUserComments < ActiveRecord::Migration[5.0]
  def change
    create_table :user_comments do |t|
      t.text :content
      t.references :commenter,index: true, foreign_key: { to_table: :users }
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
