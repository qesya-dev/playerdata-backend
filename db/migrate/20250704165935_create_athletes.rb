class CreateAthletes < ActiveRecord::Migration[8.0]
  def change
    create_table :athletes, id: false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.string :position
      t.integer :number

      t.timestamps
    end
  end
end
