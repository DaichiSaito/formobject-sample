class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
