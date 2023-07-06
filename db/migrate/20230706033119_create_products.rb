class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :fruit
      t.boolean :seeds
      t.float :cost_per_pound

      t.timestamps
    end
  end
end
