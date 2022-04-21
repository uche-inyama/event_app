class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.date :start_date
      t.date :end_date
      t.time :time
      t.text :address
      t.text :theme
      t.text :details
      t.text :image_data
      t.string :event_type
      t.string :status
      t.references :host, null: false, foreign_key: { to_table: :users }
      
      t.timestamps
    end
  end
end
