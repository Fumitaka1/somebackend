class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.bigint :post_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
