require_relative 'base_builder'

class FilterBuilder < BaseBuilder

  private

  def model
    Filter
  end

  def uniq_keys
    [ :name ]
  end

  def attrs
    { name: @data }
  end
end
