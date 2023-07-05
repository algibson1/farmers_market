class CreateFarms < ActiveRecord::Migration[7.0]
  def change
    create_table :farms do |t|
      t.string :name
      t.boolean :pick_your_own
      t.integer :acres

      t.timestamps
    end
  end
end
