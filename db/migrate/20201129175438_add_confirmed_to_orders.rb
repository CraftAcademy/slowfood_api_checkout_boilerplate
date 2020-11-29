class AddConfirmedToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :confirmed, :boolean, default: false
  end
end
