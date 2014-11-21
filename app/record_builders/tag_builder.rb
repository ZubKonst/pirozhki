require_relative 'base_builder'

class TagBuilder < BaseBuilder
  MODEL = Tag

  def attrs
    { name: @data }
  end

  private

  def uniq_keys
    [ :name ]
  end
end
