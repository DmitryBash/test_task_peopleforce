class CreateDynamicFields < ActiveRecord::Migration[7.1]
  def change
    create_table :dynamic_fields do |t|
      t.string :name, null: false
      t.string :value_type
      t.boolean :multiple, default: false
      t.belongs_to :user

      t.timestamps
    end

    add_index :dynamic_fields, 'user_id, lower(name)', unique: true
  end
end
