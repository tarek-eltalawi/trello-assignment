class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :admin
      t.string :image_url

      t.timestamps
    end
  end
end
