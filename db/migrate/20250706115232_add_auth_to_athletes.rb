class AddAuthToAthletes < ActiveRecord::Migration[8.0]
  def change
    add_column :athletes, :email, :string
    add_column :athletes, :password_digest, :string
    add_column :athletes, :refresh_token, :string
  end
end
