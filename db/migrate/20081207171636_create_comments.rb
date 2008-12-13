class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :url
      t.string :name
      t.text :link
      t.text :body

      t.timestamps
    end

    add_index :comments, :url
  end

  def self.down
    drop_table :comments
  end
end
