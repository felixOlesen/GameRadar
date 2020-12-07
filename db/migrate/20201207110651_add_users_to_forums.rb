class AddUsersToForums < ActiveRecord::Migration[5.2]
  def up
      add_reference :forums, :user, index: true
      Forum.reset_column_information
      user = User.first

      Forum.all.each do |forum|
          forum.user_id = user.id
          forum.save!
      end

      change_column_null :forums, :user_id, false
      add_foreign_key :forums, :user
  end
  def down
      remove_foreign_key :forums, :users
      remove_reference :forums, :user, index: true
  end
end
