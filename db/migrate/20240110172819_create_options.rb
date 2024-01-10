class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.belongs_to :dynamic_field
      t.string :label

      t.timestamps
    end
  end
end
