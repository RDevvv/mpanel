class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.text :newsletter_body

      t.timestamps
    end
  end
end
