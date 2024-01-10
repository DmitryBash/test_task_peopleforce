class Option < ApplicationRecord
  belongs_to :dynamic_field
  has_many :values, class_name: "DynamicValue", foreign_key: :select_value, inverse_of: :option

  validates :label, presence: true, uniqueness: { scope: [:dynamic_field_id] }
end
