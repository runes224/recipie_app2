# frozen_string_literal: true

class RenameDisplayWeghtNameColumnToIngredinentRelations < ActiveRecord::Migration[5.2]
  def change
    rename_column :ingredient_relations, :display_we_nameght_name, :display_weight_name
  end
end
