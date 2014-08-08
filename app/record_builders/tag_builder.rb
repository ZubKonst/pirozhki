require_relative 'base_builder'

class TagBuilder < BaseBuilder

  private

  def model
    Tag
  end

  def uniq_keys
    [ :name ]
  end

  def attrs
    { name: @data }
  end
end
