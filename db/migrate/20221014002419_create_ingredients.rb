class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :name
      t.json :metric, default: {}
      t.json :imperial, default: {}

      t.timestamps
    end
  end
end
