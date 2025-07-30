class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string     :name
      t.string     :url
      t.string     :username
      t.string     :followers_count, default: "0"
      t.string     :following_count, default: "0"
      t.string     :stars_count, default: "0"
      t.string     :contributions_count, default: "0"
      t.string     :image_url
      t.string     :organization
      t.string     :location
      t.text       :tags, array: true, default: [], index: true

      t.timestamps
    end
  end
end
