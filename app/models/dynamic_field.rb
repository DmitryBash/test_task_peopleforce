class DynamicField < ApplicationRecord
  TYPES = %w(string number select)

  has_many :dynamic_values
  has_many :options, dependent: :destroy, inverse_of: 'dynamic_field'
  belongs_to :user

  validates :value_type, inclusion: {in: TYPES}

  accepts_nested_attributes_for :dynamic_values, allow_destroy: true
  accepts_nested_attributes_for :options
end
