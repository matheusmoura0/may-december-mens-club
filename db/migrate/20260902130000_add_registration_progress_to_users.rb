class AddRegistrationProgressToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :registration_completed_at, :datetime
  end
end
