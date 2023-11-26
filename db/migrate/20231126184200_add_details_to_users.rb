class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :country, :string
    add_column :users, :province, :string
    add_column :users, :postal_code, :string
  end
end
