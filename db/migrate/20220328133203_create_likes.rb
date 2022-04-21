class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :guest, null: false, foreign_key: { to_table: :users}
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
