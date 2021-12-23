# frozen_string_literal: true

class DropArticlesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :articles
  end
end
