require 'set'

class BaseBuilder

  def self.find_or_create! data
    builder = new data
    builder.find_or_create!
  end

  def initialize data
    @data = data
  end

  def find_or_create!
    model.find_by uniq_attrs or model.create! attrs
  rescue ActiveRecord::RecordNotUnique
    model.find_by uniq_attrs
  end

  private

  def model
    self.class::MODEL
  end

  def uniq_attrs
    valid_keys = uniq_keys.to_set
    out = attrs.select { |key| valid_keys.include? key }
    if out.empty?
      raise ArgumentError, "Uniq attrs on #{model.name} should not be empty."
    end
    out
  end

  def attrs ;     raise 'This method should be overridden.' end
  def uniq_keys ; raise 'This method should be overridden.' end
end
