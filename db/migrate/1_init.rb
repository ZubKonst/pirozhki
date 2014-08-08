class Init < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.belongs_to :geo_point, null: false

      t.belongs_to :user,      null: false
      t.text :instagram_id,    null: false

      t.belongs_to :location,  null: false
      t.belongs_to :filter,    null: false

      t.integer :created_time, null: false
      t.integer :updated_time, null: false

      t.integer :content_type, null: false
      t.text :instagram_link,  null: false
      t.text :image_link,      null: false
      t.text :video_link

      t.text :caption
    end
    add_index :posts, :instagram_id, unique: true

    create_table :post_counters do |t|
      t.belongs_to :post,        null: false
      t.integer :likes_count,    null: false
      t.integer :comments_count, null: false
      t.integer :created_time,   null: false
    end
    add_index :post_counters, [:post_id, :created_time], unique: true


    create_table :users do |t|
      t.integer :instagram_id, null: false
      t.text :nick_name, null: false
      t.text :full_name, null: false
      t.text :image, null: false
    end
    add_index :users, :instagram_id, unique: true

    create_table :users_in_posts, id: false do |t|
      t.belongs_to :post, null: false
      t.belongs_to :user,  null: false
    end
    add_index :users_in_posts, [:post_id, :user_id], unique: true

    create_table :tags do |t|
      t.text :name, null: false
    end
    add_index :tags, :name, unique: true

    create_table :posts_tags, id: false do |t|
      t.belongs_to :post, null: false
      t.belongs_to :tag,  null: false
    end
    add_index :posts_tags, [:post_id, :tag_id], unique: true

    create_table :filters do |t|
      t.text :name, null: false
    end
    add_index :filters, :name, unique: true

    create_table :locations do |t|
      t.float :lat, null: false
      t.float :lng, null: false
      t.integer :instagram_id
      t.text  :name
    end
    add_index :locations, :instagram_id, unique: true, where: 'instagram_id IS NOT NULL'
    add_index :locations, [:lat, :lng]

    create_table :geo_points do |t|
      t.float :lat,  null: false
      t.float :lng, null: false
    end
    add_index :geo_points, [:lat, :lng], unique: true
  end
end
