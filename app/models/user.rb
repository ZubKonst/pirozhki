require_relative 'concerns/exportable'

class User < ActiveRecord::Base
  has_many :posts

  has_many :users_in_posts, dependent: :destroy
  has_many :tagged_in_posts, through: :users_in_posts, source: :post


  include Exportable
  add_export prefix: 'user',
             export_fields:  %i[ id instagram_id nick_name ]
end
