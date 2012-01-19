class AddEmailReminderToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :email_reminder, :boolean
  end
end
