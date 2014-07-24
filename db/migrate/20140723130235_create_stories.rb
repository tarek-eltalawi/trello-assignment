class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name
      t.text :description
      t.string :state
      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
