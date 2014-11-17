module Exportable
  extend ActiveSupport::Concern

  module ClassMethods

    def add_export(prefix:, export_fields: [], export_methods: [], extra_fields: nil)
      define_method :export_attrs do
        # get post fields and methods
        attrs = as_json(only: export_fields, methods: export_methods)
        # add custom hash
        attrs.merge! send(extra_fields) if extra_fields
        # add prefix to hash keys
        attrs.inject({}) do |new_attrs, (k, v)|
          new_attrs["#{prefix}_#{k}"] = v
          new_attrs
        end
      end
    end

  end
end
