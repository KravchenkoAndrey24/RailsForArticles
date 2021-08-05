class CreateTodolists < ActiveRecord::Migration[6.1]
  def change
    create_table :todolists do |t|
      t.string :title
      t.boolean :complete
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
