class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.bigint :category_id
      t.string :name
      t.string :description
      t.float :price

      t.timestamps
    end
  end
end
