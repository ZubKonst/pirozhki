require 'set'

class BaseBuilder

  def initialize post_data
    @data = post_data
  end

  def find_or_create!
    find || create!
  rescue ActiveRecord::RecordNotUnique
    find
  end

  private

  def model
    self.class::MODEL
  end

  def find
    model.find_by uniq_attrs
  end

  def create!
    model.create! attrs
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
