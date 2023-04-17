class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :post_code,           null: false, default: ""
      t.integer :prefecture_id,      null: false
      t.string :city,                null: false, default: ""
      t.string :address,             null: false, default: ""
      t.string :building
      t.string :telephone_number,    null: false, default: ""
      t.references :order,           null: false, foreign_key: true

      t.timestamps
    end
  end
end
