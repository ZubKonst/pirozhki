require_relative 'base_builder'

class TagBuilder < BaseBuilder

  def attrs
    { name: @data }
  end

  private

  def model
    Tag
  end

  def uniq_keys
    [ :name ]
  end
end
