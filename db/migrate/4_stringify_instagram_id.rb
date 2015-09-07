class StringifyInstagramId < ActiveRecord::Migration
  def up
    change_column :users, :instagram_id, :text
    change_column :locations, :instagram_id, :text
  end

  def down
    change_column :users, :instagram_id, 'integer USING CAST(instagram_id AS integer)'
    change_column :locations, :instagram_id, 'integer USING CAST(instagram_id AS integer)'
  end
end
