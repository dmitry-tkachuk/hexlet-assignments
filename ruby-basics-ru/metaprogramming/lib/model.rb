# frozen_string_literal: true

# BEGIN
require 'date'

module Model
  def self.included(base)
    base.extend(ClassMethods)
    base.instance_variable_set(:@attribute_types, {})
    base.instance_variable_set(:@attribute_defaults, {})
  end

  module ClassMethods
    def attribute(name, options = {})
      @attribute_types[name] = options[:type]
      @attribute_defaults[name] = options[:default] if options.key?(:default)

      define_method(name) do
        value = @attributes[name]
        options[:type] ? convert_type(value, options[:type]) : value
      end

      define_method("#{name}=") do |value|
        set_attribute(name, value)
      end
    end

    def attribute_types
      @attribute_types
    end

    def attribute_defaults
      @attribute_defaults
    end
  end

  def initialize(attributes = {})
    @attributes = {}
    assign_attributes(attributes)
  end

  def assign_attributes(attributes)
    attributes.each { |name, value| set_attribute(name, value) if respond_to?("#{name}=") }
  end

  def set_attribute(name, value)
    @attributes[name] = value.nil? ? default_value_for_attribute(name) : value
  end

  def default_value_for_attribute(name)
    self.class.attribute_defaults[name]
  end

  def attributes
    @attributes.transform_values { |value| convert_type(value, type_for_attribute(value)) }
  end

  private

  def convert_type(value, type)
    case type
    when :string then value.to_s
    when :integer then value.to_i
    when :float then value.to_f
    when :boolean then convert_to_boolean(value)
    when :date then convert_to_date(value)
    when :datetime then convert_to_datetime(value)
    else
      value
    end
  end

  def convert_to_boolean(value)
    return nil if value.nil?
    return true if value.to_s.downcase == 'true'
    return false if value.to_s.downcase == 'false'
    raise ArgumentError, "Invalid boolean value: #{value.inspect}"
  end

  def convert_to_date(value)
    return nil if value.nil?
    return value if value.is_a?(Date)
    return Date.parse(value.to_s) rescue nil
  end

  def convert_to_datetime(value)
    return nil if value.nil?
    return value if value.is_a?(DateTime)
    return DateTime.parse(value.to_s) rescue nil
  end

  def type_for_attribute(attribute)
    attribute_name = @attributes.key(attribute)
    self.class.attribute_types[attribute_name]
  end
end
# END
