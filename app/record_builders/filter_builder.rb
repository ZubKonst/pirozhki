require_relative 'base_builder'

class FilterBuilder < BaseBuilder

  def attrs
    { name: @data }
  end

  private

  def model
    Filter
  end

  def uniq_keys
    [ :name ]
  end
end
