class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.string :cooking_image_id
      t.string :title
      t.text :body
      t.float :rate

      t.timestamps
    end
  end
end
