class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string :username
      t.string :password_digest
    end
  end

  def down
    drop_table :users #I wonder why there isn't a seperate file for this method
  end
end
