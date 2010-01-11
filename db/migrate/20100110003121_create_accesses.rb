class CreateAccesses < ActiveRecord::Migration
  def self.up
    create_table :accesses do |t|
      t.integer :item_id
      t.string :ip
      t.string :referrer
      t.timestamps
    end
  end

  def self.down
    drop_table :accesses
  end
end
