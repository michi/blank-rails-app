class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :username, :string
      t.column :password_hash, :string
      t.column :full_name, :string
      t.timestamps
    end
    
    add_index(:users, :username)
  end

  def self.down
    drop_table :users
  end
end
