class AddHashtagSource < ActiveRecord::Migration
  def up
    create_table :hashtags do |t|
      t.text :tag_name, null: false
    end
  end

  def down
    from_hashtag = Post.where source_type: 'Source::Hashtag'
    from_hashtag.destroy_all
    drop_table :hashtags
  end
end
