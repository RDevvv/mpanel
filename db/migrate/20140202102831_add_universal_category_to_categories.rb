class AddUniversalCategoryToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :is_universal, :boolean
  end
end
