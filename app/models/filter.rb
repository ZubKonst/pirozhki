require_relative 'concerns/exportable'

class Filter < ActiveRecord::Base
  has_many :posts

  include Exportable
  add_export prefix: 'filter',
             export_fields:  %i[ id name ]
end
