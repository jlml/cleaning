class Add < ActiveRecord::Migration
  def change
  	add_colmnn :users, :auth_token, :string
  end
end
