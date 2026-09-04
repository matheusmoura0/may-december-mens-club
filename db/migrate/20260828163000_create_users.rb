class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :account_state, null: false, default: "pending"

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :account_state
    add_check_constraint :users,
      "account_state IN ('pending', 'active', 'suspended')",
      name: "users_account_state_check"
  end
end
