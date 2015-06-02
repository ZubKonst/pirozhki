module Exportable
  extend ActiveSupport::Concern

  def export_attrs
    # This is a stub, used for indexing.
    raise 'Should be redefined using `add_export` method.'
  end

  module ClassMethods

    def add_export prefix:, export_fields: [], export_methods: [], extra_fields: nil
      define_method :export_attrs do
        # get post fields and methods
        attrs = as_json only: export_fields, methods: export_methods
        # add custom hash
        if extra_fields
          extra_attrs = send extra_fields
          attrs.merge! extra_attrs
        end
        # add prefix to hash keys
        attrs.keys.each do |k|
          new_k = "#{prefix}_#{k}"
          attrs[new_k] = attrs.delete k
        end
        # result
        attrs
      end
    end

  end
end
