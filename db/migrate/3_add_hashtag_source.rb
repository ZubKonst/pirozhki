class AddHashtagSource < ActiveRecord::Migration
  def up
    create_table :hashtags do |t|
      t.text :tag_name, null: false
    end
  end

  def down
    Post.where(source_type: 'Hashtag').destroy_all
    drop_table :hashtags
  end
end
