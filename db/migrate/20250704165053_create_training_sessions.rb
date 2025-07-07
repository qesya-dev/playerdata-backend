class CreateTrainingSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :training_sessions, id: false do |t|
      t.string :id, primary_key: true
      t.datetime :date
      t.integer :duration
      t.timestamps
    end
  end
end
