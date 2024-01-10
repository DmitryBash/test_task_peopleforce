class CreateDynamicValues < ActiveRecord::Migration[7.1]
  def change
    create_table :dynamic_values do |t|
      t.string :string_value
      t.integer :number_value
      t.integer :select_value
      t.belongs_to :dynamic_field

      t.timestamps
    end
  end
end
