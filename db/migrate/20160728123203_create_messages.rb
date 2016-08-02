class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.string :channel
      t.string :user_name

      t.timestamps null: false

      t.references :user, foreign_key: true
    end
  end
end
