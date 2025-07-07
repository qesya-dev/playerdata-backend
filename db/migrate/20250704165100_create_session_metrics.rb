class CreateSessionMetrics < ActiveRecord::Migration[8.0]
  def change
    create_table :session_metrics, id: false do |t|
      t.string :id, primary_key: true
      t.string :training_session_id
      t.string :athlete_id
      t.float :distance
      t.integer :sprints
      t.float :top_speed
      t.timestamps
    end
  end
end
