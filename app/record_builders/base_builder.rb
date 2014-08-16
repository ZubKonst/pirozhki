class BaseBuilder

  def initialize(post_data)
    @data = post_data
  end

  def find_or_create!
    model.find_by(uniq_attrs) || model.create!(attrs)
  rescue ActiveRecord::RecordNotUnique
    model.find_by(uniq_attrs)
  end

  private

  def uniq_attrs
    valid_keys = uniq_keys
    attrs.select { |key| valid_keys.include?(key) }
  end
end
