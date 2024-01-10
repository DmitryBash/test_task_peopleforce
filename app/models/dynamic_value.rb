class DynamicValue < ApplicationRecord
  belongs_to :dynamic_field
  belongs_to :option, foreign_key: 'select_value', optional: true

  before_create :reject_duplication_for_has_one

  validates :string_value, if: -> { dynamic_field.value_type == "string" }, presence: true, allow_nil: true
  validates :number_value, if: -> { dynamic_field.value_type == "number" }, presence: true, allow_nil: true
  validates :select_value, if: -> { dynamic_field.value_type == "select" }, presence: true, allow_nil: true
  validate :custom_validation_method
  validate :ensure_option_is_in_same_field

  private

  def reject_duplication_for_has_one
    return if dynamic_field.multiple
    return unless self.class.exists?(dynamic_field_id: dynamic_field_id)

    self.errors.add(:base, 'Multiple records for has_one relationship detected')
    throw :abort
  end

  def custom_validation_method
    case dynamic_field.value_type
    when 'number'
      validate_attribute_absence(:string_value, :select_value, "string and select values cannot be set when type is 'number'")
    when 'string'
      validate_attribute_absence(:number_value, :select_value, "number and select values cannot be set when type is 'string'")
    when 'select'
      validate_attribute_absence(:string_value, :number_value, "string and number values cannot be set when type is 'select'")
    end
  end

  def validate_attribute_absence(*attributes, message)
    attributes.each do |attribute|
      errors.add(attribute, message) if send(attribute).present?
    end
  end

  def ensure_option_is_in_same_field
    if option && (option.dynamic_field_id != dynamic_field_id)
      errors.add(:select_value, 'is pointing to the option for other field')
    end
  end
end
