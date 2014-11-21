require_relative 'base_builder'

class FilterBuilder < BaseBuilder
  MODEL = Filter

  def attrs
    { name: @data }
  end

  private

  def uniq_keys
    [ :name ]
  end
end
