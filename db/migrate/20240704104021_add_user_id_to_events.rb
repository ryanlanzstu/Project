class AddUserIdToEvents < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :user, null: false, foreign_key: true, default: 1
  end
end
