# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false, limit: 100, default: ''
      t.string :youtube_id, null: false, unique: true
      t.string :description, limit: 500, null: false, default: ''

      t.timestamps
    end

    add_index :movies, :youtube_id, unique: true
  end
end
