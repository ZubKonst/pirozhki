class UnifyPostSource < ActiveRecord::Migration
  def up
    add_column :posts, :source_type, :text
    Post.update_all(source_type: 'GeoPoint')
    change_column_null :posts, :source_type, false

    rename_column :posts, :geo_point_id, :source_id

    remove_index :posts, :instagram_id
    add_index :posts, [:source_type, :source_id, :instagram_id], unique: true
  end

  def down
    remove_index :posts, [:source_type, :source_id, :instagram_id]
    add_index :posts, :instagram_id, unique: true

    rename_column :posts, :source_id, :geo_point_id

    Post.where.not(source_type: 'GeoPoint').destroy_all
    remove_column :posts, :source_type
  end
end
