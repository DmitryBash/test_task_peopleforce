class User < ApplicationRecord
  has_many :dynamic_fields, dependent: :destroy
  has_many :dynamic_values, through: :dynamic_fields

  accepts_nested_attributes_for :dynamic_fields

  def method_missing(*args)
    name = args[0]
    one = name.to_s.scan(/^dynamic_(.+)_value$/)[0]
    many = name.to_s.scan(/^dynamic_(.+)_values$/)[0]

    return super if one.nil? && many.nil?

    target = one ? one : many
    candidates = [target[0], target[0].gsub('_', ' ')]
    field = DynamicField.find_by(name: candidates, user_id: id)

    return super if field.nil?

    dynamic_value(field: field)
  end

  private

  def dynamic_value(field: nil)
    raise "No field found" unless field

    if field.multiple
      dynamic_values.select{|v| v.dynamic_field_id == field.id }
    else
      dynamic_values.detect{|v| v.dynamic_field_id == field.id }
    end
  end
end
