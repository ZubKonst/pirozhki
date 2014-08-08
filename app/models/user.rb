class User < ActiveRecord::Base
  has_many :posts

  has_many :users_in_posts, dependent: :destroy
  has_many :tagged_in_posts, through: :users_in_posts, source: :post

  def export_attrs
    export_fields = %i[ id instagram_id nick_name ]
    attrs = self.as_json(only: export_fields)
    Hash[ attrs.map { |k,v| ["user_#{k}", v] } ]
  end
end
