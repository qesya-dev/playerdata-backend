class AddNameToTrainingSessions < ActiveRecord::Migration[8.0]
  def change
    add_column :training_sessions, :name, :string
  end
end
